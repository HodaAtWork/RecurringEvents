#
# Recurring Events - ScheduleElement class
#
class ScheduleElement:

    def __init__(self, event, expression):
        self.event = event
        self.expression = expression

#    @property
    def event(self):
        return self.event

#    @event.setter
    def event(self, value):
        self.event = value

#    @property
    def expression(self):
        return self.expression

#    @expression.setter
    def expression(self, value):
        self.expression = value

    def isOccurring(self, event, date):
        if self.event == event:
            return self.expression.includes(date)
        else:
            return False

    def nextOccurrence(self, date):
       return self.expression.nextOccurrence(date)
