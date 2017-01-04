### 0.6.0 (2017-01-04)

* move support for passing blocks into `#visit` from `PageObject` to `TrainingWheels`
* move support for `#use` (prefer the `#new` method) from `PageObject` to `TrainingWheels`
* require training_wheels file separately to use `TrainingWheels`

### 0.5.8 (2016-12-30)

* fix #fill_form issue for TextArea (thanks Tony Godwin!)

### 0.5.7 (2016-09-21)

* add support for Watir 6.0.0.betas

### 0.5.6 (2016-05-21)

* add instance method for page_url on PageObject

### 0.5.5 (2016-04-22)

* fix bug for filling forms with Hash

### 0.5.4 (2016-04-20)

* don't specify activesupport version

### 0.5.3 (2016-03-03)

* only attempt fill forms with values defined in model instance

### 0.5.2 (2016-02-22)

* removed feature for locating a collection based on pluralizing the element name

### 0.5.1 (2016-02-17)

* fixed bugs in training wheels 

### 0.5.0 (2016-02-16)

* split new definition of elements & collections into a sub-class

### 0.4.1 (2016-02-15)

* alias fill_form with populate_page_with (page_object gem equivalent)

### 0.4.0 (2016-02-12)

* define elements & collections with locator hashes as well as blocks
* supports auto-form filling data from any object that converts to a hash
* allow setting browser with class method
* runtime dependency removed for watir_model and watir_session

### 0.3.4 (2016-01-25)

* elements inherited in subclasses

### 0.3.3 (2016-01-30)

* switch from test-model to watir_model
* update to latest watir_session implementation

### 0.3.2 (2016-01-25)

* clear field before typing into it

### 0.3.1 (2016-01-25)

* wait for element before interacting with it

### 0.3.0 (2016-01-24)

* Singleton replaced with usage of watir_session gem
* page_url methods can take parameters
* Default form filling method with usage of test-model gem
* Pluralizing element names obtains collections of those elements
* `#visit` and `#use` methods provided for passing blocks to the Page Object

### 0.1.1 (2015-07-30)

* Browser session stored in singleton
* Page Objects initialize without parameters
* Default actions for setters on elements

### 0.1.0 (2015-07-15)

* initial commit
