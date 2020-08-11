#
# Recurring Events - Schedule class
#
class Schedule:

    def __init__(self):
        self.scheduleElements = []

#    @property
#    def scheduleElements(self):
#        return self.scheduleElements

#    @scheduleElements.setter
    def addScheduleElement(self, value):
        self.scheduleElements.append(value)

    def isOccurring(self, event, date):
        for scheduleElement in self.scheduleElements:
            if scheduleElement.isOccurring(event, date):
                return True
        return False

    def nextOccurrence(self, event, date):
        for scheduleElement in self.scheduleElements:
            if scheduleElement.event == event:
                return scheduleElement.nextOccurrence(date)
        return None
