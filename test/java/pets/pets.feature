Feature: PetStore API Automation
  This feature tests the PetStore API for adding, updating, and retrieving pets.

  Background:
    * def urlBase = 'https://petstore.swagger.io/v2'
    * def petPath = '/pet'
    * def jsonData = read('classpath:json/Pet.json')
    * def updatedPetData = read('classpath:json/PetUpdate.json')

  Scenario: Add a new pet to the store
    Given url urlBase + petPath
    And request jsonData
    When method POST
    Then status 200
    And match response.id == 12345
    And match response.name == 'Max'

  Scenario: Get the added pet by ID
    Given url urlBase + petPath + '/12345'
    When method GET
    Then status 200
    And match response.name == 'Max'
    And match response.status == 'available'

  Scenario: Update the pet's name and status
    Given url urlBase + petPath
    And request updatedPetData
    When method PUT
    Then status 200
    And match response.name == 'Buddy'
    And match response.status == 'sold'

  Scenario: Get the updated pet by status
    Given url urlBase + '/pet/findByStatus'
    And param status = 'sold'
    When method GET
    Then status 200
    * def pets = response
    * def filteredPet = karate.filter(pets, function(pet){ return pet.name == 'Buddy' })
    * print filteredPet
