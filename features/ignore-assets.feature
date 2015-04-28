Feature: Ignore Assets
  Scenario: it should ignore when running server
    Given the Server is running at "middleman-app"
    When I go to "/javascripts/module.json"
    Then I should see:
    """
    <h1>File Not Found</h1>
    """
    And I go to "/javascripts/module.xml"
    Then I should see:
    """
    <h1>File Not Found</h1>
    """
    And I go to "/stylesheet/module.json"
    Then I should see:
    """
    <h1>File Not Found</h1>
    """
    And I go to "/stylesheet/module.xml"
    Then I should see:
    """
    <h1>File Not Found</h1>
    """

  Scenario: it should ignore on build
    Given a built app at "middleman-app" with flags "--verbose --clean"
    When I cd to "build"
    Then the following files should not exist:
      | javascripts/module.json |
      | javascripts/module.xml |
      | stylesheets/module.json |
      | stylesheets/module.xml |