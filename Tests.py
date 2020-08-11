import unittest, datetime
from Schedule import Schedule
from ScheduleElement import ScheduleElement
from TemporalExpression import TemporalExpression, DailyTE, DayInMonthTE, DayInWeekTE, FirstDayInMonthTE, RangeEachYearTE

class RecurringEventsTestCase(unittest.TestCase):
    def setUp(self):
        self.tstSchedule = Schedule()
        self.tstSchedule.addScheduleElement(self.dailyScheduleElement())
        self.tstSchedule.addScheduleElement(self.weeklyScheduleElement())
        self.tstSchedule.addScheduleElement(self.monthlyScheduleElement())
        self.tstSchedule.addScheduleElement(self.yearlyScheduleElement())
        self.tstSchedule.addScheduleElement(self.firstOfMonthScheduleElement())

    def tearDown(self):
        self.tstSchedule = Schedule()

    def dailyEvent(self):
        return 'NewsReport'

    def weeklyEvent(self):
        return 'TimeSheet'

    def monthlyEvent(self):
        return 'SalaryPayment'

    def yearlyEvent(self):
        return 'Taxes'

    def firstOfMonthEvent(self):
        return 'BudgetRaise'

    def dailyScheduleElement(self):
        return ScheduleElement(self.dailyEvent(), DailyTE())

    def weeklyScheduleElement(self):
        return ScheduleElement(self.weeklyEvent(), DayInWeekTE(2))

    def monthlyScheduleElement(self):
        return ScheduleElement(self.monthlyEvent(), DayInMonthTE(4, 3))

    def yearlyScheduleElement(self):
        return ScheduleElement(self.yearlyEvent(), RangeEachYearTE(2, 3, 1, 31))

    def firstOfMonthScheduleElement(self):
        return ScheduleElement(self.firstOfMonthEvent(), FirstDayInMonthTE())


class EventIsOcurringTestCase(RecurringEventsTestCase):
    def test_NumberOfscheduleElements(self):
        listSize = len(self.tstSchedule.scheduleElements)
        self.assertEqual('foo'.upper(), 'FOO')
        print(listSize)
        self.assertEqual(listSize, 5)

    def test_daily(self):
        self.assertTrue(self.tstSchedule.isOccurring(self.dailyEvent(), datetime.date(2018, 3, 23)))

    def test_weekly(self):
        self.assertTrue(self.tstSchedule.isOccurring(self.weeklyEvent(), datetime.date(2018, 3, 21))) #day 2 = Wednesday (Python)
        self.assertFalse(self.tstSchedule.isOccurring(self.weeklyEvent(), datetime.date(2018, 3, 19))) #day 2 = Monday (Smalltalk)

    def test_monthly(self):
        self.assertTrue(self.tstSchedule.isOccurring(self.monthlyEvent(), datetime.date(2018, 3, 16))) #day 4 = Friday (Python)
        self.assertFalse(self.tstSchedule.isOccurring(self.monthlyEvent(), datetime.date(2018, 3, 14))) #day 4 = Wednesday (Smalltalk)

    def test_yearly(self):
        self.assertTrue(self.tstSchedule.isOccurring(self.yearlyEvent(), datetime.date(2018, 2, 1)))
        self.assertTrue(self.tstSchedule.isOccurring(self.yearlyEvent(), datetime.date(2018, 3, 31)))
        self.assertFalse(self.tstSchedule.isOccurring(self.yearlyEvent(), datetime.date(2018, 4, 1)))

    def test_FirstOfMonth(self):
        self.assertTrue(self.tstSchedule.isOccurring(self.firstOfMonthEvent(), datetime.date(2018, 4, 1)))
        self.assertFalse(self.tstSchedule.isOccurring(self.firstOfMonthEvent(), datetime.date(2018, 4, 30)))


if __name__ == '__main__':
    unittest.main()
