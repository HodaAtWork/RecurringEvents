#
# Recurring Events - abstract Temporal Expression class and its subclasses
#
import datetime

class TemporalExpression:
    def includes(self, date):
       raise NotImplementedError()

    def nextOccurrence(self, date):
       raise NotImplementedError()

    def lastDayInMonth(self, date):
        next_month = date.replace(day=28) + datetime.timedelta(days=4)
        return next_month - datetime.timedelta(days=next_month.day)
    #date argument like datetime.date(2018, monthNumber, 1)
    # returns e.g. 2018-03-31


class DailyTE(TemporalExpression):
    def nextOccurrence(self, date):
        return date + datetime.timedelta(days=1)

    def includes(self, date):
        return True


class DayInMonthTE(TemporalExpression):
    def __init__(self, dayIndex, count):
        self.dayIndex = dayIndex
        self.count = count

#    @property
    def dayIndex(self):
        return self.dayIndex

#    @dayIndex.setter
    def dayIndex(self, value):
        self.dayIndex = value

#    @property
    def count(self):
        return self.count

#    @dayIndex.setter
    def count(self, value):
        self.count = value

    def weekInMonth(self, dayInMonthNumber):
        return (dayInMonthNumber - 1) // 7 + 1

    def weekFromStartMatches(self, date):
        return self.weekInMonth(date.day) == self.count

    def weekFromEndMatches(self, date):
        daysLeftInMonth = (self.lastDayInMonth(date) - date).days
        return self.weekInMonth(daysLeftInMonth) == abs(self.count)

    def weekMatches(self, date):
        if self.count > 0:
            return self.weekFromStartMatches(date)
        else:
            return self.weekFromEndMatches(date)

    def dayMatches(self, date):
        return datetime.date.weekday(date) == self.dayIndex

    def includes(self, date):
        return self.dayMatches(date) and self.weekMatches(date)

    def nextOccurrence(self, date):
        fromDate = self.lastDayInMonth(date)
        for i in range(1, 32):
            checkDate = fromDate + datetime.timedelta(days = i)
            if self.includes(checkDate):
                return checkDate


class DayInWeekTE(TemporalExpression):
    def __init__(self, dayNumber):
        self.dayNumber = dayNumber

#    @property
    def dayNumber(self):
        return self.dayNumber

#    @dayNumber.setter
    def dayNumber(self, value):
        self.dayNumber = value

    def includes(self, date):
        # Phyton monday = 0. Smalltalk monday = 2!
        return datetime.date.weekday(date)

    def nextOccurrence(self, date):
        for i in range(1, 8):
            checkDate = date + datetime.timedelta(days = i)
            if self.includes(checkDate):
                return checkDate


class FirstDayInMonthTE(TemporalExpression):
    def nextOccurrence(self, date):
        return self.lastDayInMonth(date) + datetime.timedelta(days = 1)

    def includes(self, date):
        return date.day == 1 



class RangeEachYearTE(TemporalExpression):
    def __init__(self, startMonth, endMonth, startDay, endDay):
        self.startMonth = startMonth
        self.endMonth = endMonth
        self.startDay = startDay
        self.endDay = endDay

#    @property
    def startMonth(self):
        return self.startMonth

#    @startMonth.setter
    def startMonth(self, value):
        self.startMonth = value

#    @property
    def endMonth(self):
        return self.endMonth

#    @endMonth.setter
    def endMonth(self, value):
        self.endMonth = value

#    @property
    def startDay(self):
        return self.startDay

#    @startDay.setter
    def startDay(self, value):
        self.startDay = value

#    @property
    def endDay(self):
        return self.endDay

#    @endDay.setter
    def endDay(self, value):
        self.endDay = value

    def isStartDate(self, date):
        return date.month == self.startMonth and date.day == self.startDay

    def monthsInclude(self, date):
        month = date.month
        return month > self.startMonth and month < self.endMonth

    def startMonthIncludes(self, date):
        if date.month != self.startMonth:
            return False
        elif self.startDay == 1:
            return True
        else:
            return date.day >= self.startDay

    def endMonthIncludes(self, date):
        if date.month != self.endMonth:
            return False
        elif self.endDay == 1:
            return True
        else:
            return date.day <= self.endDay

    def includes(self, date):
        return self.monthsInclude(date) or (self.startMonthIncludes(date) or self.endMonthIncludes(date))

    def nextOccurrence(self, date):
        for i in range(1, 366):
            checkDate = date + datetime.timedelta(days = i)
            if self.includes(checkDate) and self.isStartDate(date):
                return checkDate
