Class {
	#name : #MyBootstrap,
	#superclass : #WAComponent,
	#instVars : [
		'showModal'
	],
	#category : #'DD-Bootstrap'
}

{ #category : #'class initialization' }
MyBootstrap class >> initialize [
	"MyBootstrap initialize"

	(WAAdmin register: self asApplicationAt: 'my-bootstrap')
		addLibrary: JQDevelopmentLibrary;
		addLibrary: TBSDeploymentLibrary
]

{ #category : #'as yet unclassified' }
MyBootstrap >> hideModal [
showModal := false.
]

{ #category : #'as yet unclassified' }
MyBootstrap >> initialize [
super initialize .
showModal := false.

]

{ #category : #'as yet unclassified' }
MyBootstrap >> modalOptions [
	^Dictionary new
     at: 'backdrop' put: 'static';
     yourself.
]

{ #category : #rendering }
MyBootstrap >> renderContentOn: html [
	self renderMyButtons: html.
	self renderMyModal: html.
]

{ #category : #rendering }
MyBootstrap >> renderMyButtons: html [
	html anchor 
		class:'btn btn-primary';
		callback: [self showModal];
		with: 'Show modal'.

	html anchor 
		class:'btn btn-default';
		callback: [self hideModal];
		with: 'Hide modal'.
]

{ #category : #rendering }
MyBootstrap >> renderMyModal: html [
	html document
		addLoadScript: ((html jQuery id: 'myModal') call: 'modal'with: self modalOptions).
	showModal
		ifTrue: [ html tbsModal
				id: 'myModal';
				attributeAt: 'data-show' put: 'true';
				with: [ html
						tbsModalDialog: [ html
								tbsModalContent: [ html
										tbsModalHeader: [ html tbsModalCloseIcon.
											html tbsModalTitle
												level: 4;
												with: 'Modal title 2' ].
									html
										tbsModalBody: [ html space.
											html tbsButton
												bePrimary;
												with: 'Primary'.
											html space.
											html tbsButton
												beSuccess;
												with: 'Success' ].
									html
										tbsModalFooter: [ html tbsButton: 'Close'.
											html tbsButton
												bePrimary;
												with: 'Save changes' ] ] ] ] ]
]

{ #category : #accessing }
MyBootstrap >> showModal [
showModal := true.
]
