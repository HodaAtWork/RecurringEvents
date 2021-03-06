TestCase subclass: #RecurringEventsTestCase
	instanceVariableNames: 'schedule'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events-Tests'!

!RecurringEventsTestCase methodsFor: 'resources' stamp: ' 6/4/11 07:53'!
dailyEvent
	
	^#NewsReport! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: 'HenkOpDenAkker 4/8/2011 09:11'!
firstOfMonthEvent
	^ #BudgetRaise! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: ' 6/4/11 07:53'!
dailyScheduleElement
	
	^ScheduleElement
		event: self dailyEvent
		expression: DailyTE new! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: 'HenkOpDenAkker 4/6/2011 09:31'!
weeklyScheduleElement
	
	^ScheduleElement
		event: self weeklyEvent
		expression: (DayInWeekTE dayOfWeek: 2)! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: ' 6/4/11 07:53'!
yearlyScheduleElement
	
	^ScheduleElement
		event: #Taxes
		expression:
			(RangeEachYearTE startMonth: 2 endMonth: 3 startDay: 1 endDay: 31)! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: 'Anonymous 7/26/2018 17:54'!
myMonthlyEvent
	
	^#Count! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: ' 6/4/11 07:53'!
weeklyEvent
	
	^#TimeSheet! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: ' 6/4/11 07:53'!
yearlyEvent
	
	^#Taxes! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: 'HenkOpDenAkker 4/6/2011 09:31'!
monthlyScheduleElement
	
	^ScheduleElement
		event: self monthlyEvent
		expression: (DayInMonthTE dayOfWeek: 4 numberInMonth: 3)! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: ' 6/4/11 07:53'!
monthlyEvent
	
	^#SalaryPayments! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: 'Anonymous 7/27/2018 10:01'!
myMonthlyScheduleElement
	
	^ScheduleElement
		event: self myMonthlyEvent
		expression: (DayInMonthTE dayOfWeek: 6 numberInMonth: -1)! !

!RecurringEventsTestCase methodsFor: 'resources' stamp: 'HenkOpDenAkker 4/8/2011 09:11'!
firstOfMonthScheduleElement
	^ ScheduleElement event: self firstOfMonthEvent expression: FirstDayInMonthTE new! !


!RecurringEventsTestCase methodsFor: 'running' stamp: 'Anonymous 7/26/2018 17:56'!
setUp
	schedule := (RESchedule new)
		addScheduleElement: self dailyScheduleElement;
		addScheduleElement: self weeklyScheduleElement;
		addScheduleElement: self monthlyScheduleElement;
		addScheduleElement: self yearlyScheduleElement;
		addScheduleElement: self firstOfMonthScheduleElement;
		addScheduleElement: self myMonthlyScheduleElement;
		yourself! !

!RecurringEventsTestCase methodsFor: 'running' stamp: ' 6/4/11 07:53'!
tearDown
	
	! !


RecurringEventsTestCase subclass: #EventIsOccurringTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events-Tests'!

!EventIsOccurringTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testWeekly
	
	self
		assert:
			(schedule
				isOccurring: self weeklyEvent
				on: (Date readFrom: 'Nov 26, 2001' readStream)).
	self
		deny:
			(schedule
				isOccurring: self weeklyEvent
				on: (Date readFrom: 'Nov 27, 2001' readStream)).
	self
		assert:
			(schedule
				isOccurring: self weeklyEvent
				on: (Date readFrom: 'Sep 5, 2005' readStream))! !

!EventIsOccurringTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testYearly
	
	self
		assert:
			(schedule
				isOccurring: self yearlyEvent
				on: (Date readFrom: 'Feb 1, 2002' readStream)).
	self
		assert:
			(schedule
				isOccurring: self yearlyEvent
				on: (Date readFrom: 'Mar 31, 2002' readStream)).
	self
		deny:
			(schedule
				isOccurring: self yearlyEvent
				on: (Date readFrom: 'Apr 1, 2002' readStream))! !

!EventIsOccurringTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testDaily
	
	self
		assert:
			(schedule
				isOccurring: self dailyEvent
				on: (Date readFrom: 'Nov 26, 2001' readStream))! !

!EventIsOccurringTestCase methodsFor: 'test cases' stamp: 'HenkOpDenAkker 4/8/2011 09:16'!
testFirstOfMonth
	self assert: (schedule isOccurring: self firstOfMonthEvent on: (Date readFrom: 'Apr 1, 2008' readStream)).
	self deny: (schedule isOccurring: self firstOfMonthEvent on: (Date readFrom: 'Apr 30, 2008' readStream))! !

!EventIsOccurringTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testMonthly
	
	self
		assert:
			(schedule
				isOccurring: self monthlyEvent
				on: (Date readFrom: 'Dec 19, 2001' readStream)).
	self
		deny:
			(schedule
				isOccurring: self monthlyEvent
				on: (Date readFrom: 'Dec 19, 2002' readStream))! !


RecurringEventsTestCase subclass: #NextOccurrenceEventTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events-Tests'!

!NextOccurrenceEventTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testWeekly
	
	self
		assert:
			(schedule
				nextOccurrence: self weeklyEvent
				from: (Date readFrom: 'Nov 26, 2001' readStream))
				= (Date readFrom: 'Dec 3, 2001' readStream).
	self
		assert:
			(schedule
				nextOccurrence: self weeklyEvent
				from: (Date readFrom: 'Aug 31, 2005' readStream))
				= (Date readFrom: 'Sep 5, 2005' readStream).
	self
		assert:
			(schedule
				nextOccurrence: self weeklyEvent
				from: (Date readFrom: 'Sep 5, 2005' readStream))
				= (Date readFrom: 'Sep 12, 2005' readStream)! !

!NextOccurrenceEventTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testYearly
	
	self
		assert:
			(schedule
				nextOccurrence: self yearlyEvent
				from: (Date readFrom: 'Feb 1, 2002' readStream))
				= (Date readFrom: 'Feb 1, 2003' readStream).
	self
		assert:
			(schedule
				nextOccurrence: self yearlyEvent
				from: (Date readFrom: 'Jan 31, 2001' readStream))
				= (Date readFrom: 'Feb 1, 2001' readStream)! !

!NextOccurrenceEventTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testDaily
	
	self
		assert:
			(schedule
				nextOccurrence: self dailyEvent
				from: (Date readFrom: 'Nov 26, 2001' readStream))
				= (Date readFrom: 'Nov 27, 2001' readStream)! !

!NextOccurrenceEventTestCase methodsFor: 'test cases' stamp: 'HenkOpDenAkker 4/8/2011 09:17'!
testFirstOfMonth
	self
		assert:
			(schedule nextOccurrence: self firstOfMonthEvent from: (Date readFrom: 'Mar 31, 2008' readStream))
				= (Date readFrom: 'Apr 1, 2008' readStream).
	self
		assert:
			(schedule nextOccurrence: self firstOfMonthEvent from: (Date readFrom: 'Apr 19, 2008' readStream))
				= (Date readFrom: 'May 1, 2008' readStream).
	self
		deny:
			(schedule nextOccurrence: self firstOfMonthEvent from: (Date readFrom: 'Feb 29, 2008' readStream))
				= (Date readFrom: 'May 1, 2008' readStream)! !

!NextOccurrenceEventTestCase methodsFor: 'test cases' stamp: 'Anonymous 7/27/2018 09:36'!
testMonthly2
	
	self
		assert:
			(schedule
				nextOccurrence: self myMonthlyEvent
				from: (Date readFrom: 'Oct 2, 2018' readStream))
				= (Date readFrom: 'Nov 30, 2018' readStream)! !

!NextOccurrenceEventTestCase methodsFor: 'test cases' stamp: ' 6/4/11 07:53'!
testMonthly
	
	self
		assert:
			(schedule
				nextOccurrence: self monthlyEvent
				from: (Date readFrom: 'Dec 19, 2001' readStream))
				= (Date readFrom: 'Jan 16, 2002' readStream)! !
Object subclass: #RESchedule
	instanceVariableNames: 'scheduleElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!RESchedule methodsFor: 'initialize-release' stamp: ' 6/4/11 10:06'!
initialize
	
	self scheduleElements: OrderedCollection new! !


!RESchedule methodsFor: 'adding' stamp: ' 6/4/11 10:06'!
addScheduleElement: aScheduleElement
	
	self scheduleElements add: aScheduleElement! !


!RESchedule methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrence: anEvent from: aDate
	
	| scheduleElement |
	scheduleElement := self scheduleElements
		detect: [:each | each event = anEvent]
		ifNone: [^nil].
	^scheduleElement nextOccurrence: anEvent from: aDate! !

!RESchedule methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
occurrences: anEvent from: fromDate to: endDate
	
	! !

!RESchedule methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
isOccurring: anEvent on: aDate
	
	self scheduleElements
		detect: [:each | each isOccurring: anEvent on: aDate]
		ifNone: [^false].
	^true! !


!RESchedule methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
scheduleElements
	
	^scheduleElements! !

!RESchedule methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
scheduleElements: anObject
	
	scheduleElements := anObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

RESchedule class
	instanceVariableNames: ''!

!RESchedule class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
new
	
	^self basicNew initialize! !


Object subclass: #ScheduleElement
	instanceVariableNames: 'event expression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!ScheduleElement methodsFor: 'printing' stamp: ' 6/4/11 10:06'!
printOn: aStream
	
	aStream nextPutAll: self event! !


!ScheduleElement methodsFor: 'private' stamp: ' 6/4/11 10:06'!
setEvent: anEvent expression: anExpression
	
	event := anEvent.
	expression := anExpression! !


!ScheduleElement methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
expression
	
	^expression! !

!ScheduleElement methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
expression: aValue
	
	expression := aValue! !

!ScheduleElement methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
event
	
	^event! !

!ScheduleElement methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
event: aValue
	
	event := aValue! !


!ScheduleElement methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrence: anEvent from: aDate
	
	^self expression nextOccurrenceFrom: aDate! !

!ScheduleElement methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
occurrences: anEvent from: fromDate to: endDate
	
	! !

!ScheduleElement methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
isOccurring: anEvent on: aDate
	
	anEvent = self event
		ifTrue: [^self expression includes: aDate]
		ifFalse: [^false]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ScheduleElement class
	instanceVariableNames: ''!

!ScheduleElement class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
event: anEvent expression: anExpression
	
	^self new setEvent: anEvent expression: anExpression! !


Object subclass: #TemporalExpression
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!TemporalExpression methodsFor: 'private' stamp: 'HenkOpDenAkker 4/8/2011 09:08'!
lastDayInMonth: aDate
	^ Date newDay: aDate daysInMonth month: aDate monthIndex year: aDate year! !


!TemporalExpression methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrenceFrom: aDate
	
	self subclassResponsibility! !


!TemporalExpression methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
includes: aDate
	
	self subclassResponsibility! !


TemporalExpression subclass: #DailyTE
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!DailyTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
includes: aDate
	
	^true! !


!DailyTE methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrenceFrom: aDate
	
	^aDate addDays: 1! !


TemporalExpression subclass: #DayInMonthTE
	instanceVariableNames: 'dayIndex count'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!DayInMonthTE methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrenceFrom: aDate
	
	| checkDate fromDate |
	fromDate := self lastDayInMonth: aDate.
	1
		to: 31
		do:
			[:index | 
			checkDate := fromDate addDays: index.
			(self includes: checkDate) ifTrue: [^checkDate]]! !


!DayInMonthTE methodsFor: 'private' stamp: ' 6/4/11 10:06'!
weekInMonth: aDayNumber
	
	^(aDayNumber - 1) // 7 + 1! !

!DayInMonthTE methodsFor: 'private' stamp: ' 6/4/11 10:06'!
setDayOfWeek: anInteger numberInMonth: aCount
	
	dayIndex := anInteger.
	count := aCount! !


!DayInMonthTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
includes: aDate
	
	^(self dayMatches: aDate) and: [self weekMatches: aDate]! !

!DayInMonthTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
dayMatches: aDate
	
	^aDate weekdayIndex = self dayIndex! !

!DayInMonthTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
weekMatches: aDate
	
	^count > 0
		ifTrue: [self weekFromStartMatches: aDate]
		ifFalse: [self weekFromEndMatches: aDate]! !

!DayInMonthTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
weekFromStartMatches: aDate
	
	^(self weekInMonth: aDate dayOfMonth) = count! !

!DayInMonthTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
weekFromEndMatches: aDate
	
	| daysLeftInMonth |
	daysLeftInMonth := aDate daysInMonth - aDate dayOfMonth + 1.
	^(self weekInMonth: daysLeftInMonth) = self count abs! !


!DayInMonthTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
count: aValue
	
	count := aValue! !

!DayInMonthTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
dayIndex: aValue
	
	dayIndex := aValue! !

!DayInMonthTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
dayIndex
	
	^dayIndex! !

!DayInMonthTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
count
	
	^count! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DayInMonthTE class
	instanceVariableNames: ''!

!DayInMonthTE class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
dayOfWeek: anInteger numberInMonth: aCount
	
	^self new setDayOfWeek: anInteger numberInMonth: aCount! !


TemporalExpression subclass: #DayInWeekTE
	instanceVariableNames: 'dayNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!DayInWeekTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
includes: aDate
	
	^aDate weekdayIndex = dayNumber! !


!DayInWeekTE methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrenceFrom: aDate
	
	| checkDate |
	1
		to: 7
		do:
			[:index | 
			checkDate := aDate addDays: index.
			(self includes: checkDate) ifTrue: [^checkDate]]! !


!DayInWeekTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
dayNumber: aValue
	
	dayNumber := aValue! !

!DayInWeekTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
dayNumber
	
	^dayNumber! !


!DayInWeekTE methodsFor: 'private' stamp: ' 6/4/11 10:06'!
setDayOfWeek: anInteger
	
	dayNumber := anInteger! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DayInWeekTE class
	instanceVariableNames: ''!

!DayInWeekTE class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
dayOfWeek: anInteger
	
	^self new setDayOfWeek: anInteger! !


TemporalExpression subclass: #FirstDayInMonthTE
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!FirstDayInMonthTE methodsFor: 'testing' stamp: 'HenkOpDenAkker 4/8/2011 09:05'!
includes: aDate
	^ aDate dayOfMonth = 1! !


!FirstDayInMonthTE methodsFor: 'inquiries' stamp: 'HenkOpDenAkker 4/8/2011 09:07'!
nextOccurrenceFrom: aDate
	^ (self lastDayInMonth: aDate) addDays: 1! !


TemporalExpression subclass: #RangeEachYearTE
	instanceVariableNames: 'startMonth endMonth startDay endDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recurring-Events'!

!RangeEachYearTE methodsFor: 'inquiries' stamp: ' 6/4/11 10:06'!
nextOccurrenceFrom: aDate
	
	| checkDate |
	1
		to: 365
		do:
			[:index | 
			checkDate := aDate addDays: index.
			((self includes: checkDate) and: [self isStartDate: checkDate])
				ifTrue: [^checkDate]]! !


!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
endMonth
	
	^endMonth! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
endDay
	
	^endDay! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
endDay: aValue
	
	endDay := aValue! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
endMonth: aValue
	
	endMonth := aValue! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
startDay
	
	^startDay! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
startDay: aValue
	
	startDay := aValue! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
startMonth
	
	^startMonth! !

!RangeEachYearTE methodsFor: 'accessing' stamp: ' 6/4/11 10:06'!
startMonth: aValue
	
	startMonth := aValue! !


!RangeEachYearTE methodsFor: 'private' stamp: ' 6/4/11 10:06'!
setStartMonth: startMonthOfYearIndex endMonth: endMonthOfYearIndex startDay: startDayIndex endDay: endDayIndex
	
	startMonth := startMonthOfYearIndex.
	endMonth := endMonthOfYearIndex.
	startDay := startDayIndex.
	endDay := endDayIndex! !


!RangeEachYearTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
includes: aDate
	
	^(self monthsInclude: aDate)
		or: [(self startMonthIncludes: aDate) or: [self endMonthIncludes: aDate]]! !

!RangeEachYearTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
isStartDate: aDate
	
	^aDate monthIndex = self startMonth
		and: [aDate dayOfMonth = self startDay]! !

!RangeEachYearTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
monthsInclude: aDate
	
	| month |
	month := aDate monthIndex.
	^month > self startMonth and: [month < self endMonth]! !

!RangeEachYearTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
startMonthIncludes: aDate
	
	aDate monthIndex ~= self startMonth ifTrue: [^false].
	self startDay = 1 ifTrue: [^true].
	^aDate dayOfMonth >= self startDay! !

!RangeEachYearTE methodsFor: 'testing' stamp: ' 6/4/11 10:06'!
endMonthIncludes: aDate
	
	aDate monthIndex ~= self endMonth ifTrue: [^false].
	self endDay = 1 ifTrue: [^true].
	^aDate dayOfMonth <= self endDay! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

RangeEachYearTE class
	instanceVariableNames: ''!

!RangeEachYearTE class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
startMonth: startMonthOfYearIndex endMonth: endMonthOfYearIndex
	
	^self new setStartMonth: startMonthOfYearIndex endMonth:
			endMonthOfYearIndex startDay: 1 endDay: 1! !

!RangeEachYearTE class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
startMonth: startMonthOfYearIndex endMonth: endMonthOfYearIndex startDay: startDayIndex endDay: endDayIndex
	
	^self new setStartMonth: startMonthOfYearIndex endMonth:
			endMonthOfYearIndex startDay: startDayIndex endDay: endDayIndex! !

!RangeEachYearTE class methodsFor: 'instance creation' stamp: ' 6/4/11 10:06'!
month: aMonth
	
	^self new setStartMonth: aMonth endMonth: aMonth startDay: 1 endDay: 1! !

