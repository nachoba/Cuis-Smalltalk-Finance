'From Cuis 4.2 of 25 July 2013 [latest update: #1969] on 4 April 2014 at 5:17:25.124179 pm'!
'Description Please enter a description for this package'!
!provides: 'Finance' 1 0!
!classDefinition: #PresentValue category: #'Finance-Core'!
Object subclass: #PresentValue
	instanceVariableNames: 'cashFlow years discountRate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Finance-Core'!
!classDefinition: 'PresentValue class' category: #'Finance-Core'!
PresentValue class
	instanceVariableNames: ''!

!classDefinition: #NetPresentValue category: #'Finance-Core'!
PresentValue subclass: #NetPresentValue
	instanceVariableNames: 'investment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Finance-Core'!
!classDefinition: 'NetPresentValue class' category: #'Finance-Core'!
NetPresentValue class
	instanceVariableNames: ''!


!PresentValue commentStamp: '<historical>' prior: 0!
A PresentValue is a class that calculates the Present Value (PV) of a certain -and fixed- cashflow over n number of years given a known discount rate.


Instance Variables
	cashFlow:		The amount of the annual cash to be received.
	discountRate:	A reference interest rate to be used as the cost of money. 
	years:			The number of years of the given cash flow.


| aCashFlow |
aCashFlow := PresentValue new.
aCashFlow setCashFlow: 100 discountRate: 10  years: 5.
aCashFlow calculatePV. !

!NetPresentValue commentStamp: '<historical>' prior: 0!
A NetPresentValue is a class that calculates the Net Present Value of an in investment, with promised annual cashflows.

Instance Variables
	investment:		The current price of the investment.

| aNPV |
aNPV:= NetPresentValue new.
aNPV setCashFlow: 100 discountRate: 10 years: 5 investment: 400.
aNPV calculateNPV.!

!PresentValue methodsFor: 'calculations' stamp: 'IS 4/4/2014 17:11'!
calculatePV
	| flows decimalInterest |
	decimalInterest _ discountRate / 100.0.
	flows _ OrderedCollection new.
	[ years = 0 ] whileFalse: [ flows add: cashFlow / ((1 + decimalInterest) raisedTo: years).
					years _ years - 1 ].
				
	^ flows inject: 0 into: [ :sum :each | sum + each ]
	! !

!PresentValue methodsFor: 'accessing' stamp: 'IS 4/4/2014 17:05'!
cashFlow
	^ cashFlow! !

!PresentValue methodsFor: 'accessing' stamp: 'IS 4/4/2014 17:06'!
discountRate
	^ discountRate.! !

!PresentValue methodsFor: 'accessing' stamp: 'IS 4/4/2014 17:09'!
setCashFlow: aNumber1 discountRate: aNumber2 years: aNumber3

	cashFlow 		_ aNumber1.
	discountRate 	_ aNumber2.
	years			_ aNumber3! !

!NetPresentValue methodsFor: 'calculations' stamp: 'IS 4/4/2014 17:16'!
calculateNPV
	| pv |
	pv _ PresentValue new.
	pv setCashFlow: cashFlow  discountRate: discountRate years: years.
	^ investment negated + pv calculatePV ! !

!NetPresentValue methodsFor: 'accessing' stamp: 'IS 4/4/2014 17:15'!
investment
	^ investment! !

!NetPresentValue methodsFor: 'accessing' stamp: 'IS 4/4/2014 17:15'!
setCashFlow: aNumber1 discountRate: aNumber2 years: aNumber3 investment: aNumber4
	cashFlow 		_ aNumber1.
	discountRate	_ aNumber2.
	years			_ aNumber3.
	investment		_ aNumber4! !
