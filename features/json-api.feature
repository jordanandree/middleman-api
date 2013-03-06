Feature: JSON API
  Scenario: json frontmatter
    Given the Server is running at "middleman-app"
    When I go to "/test.json"
    Then I should see:
    """
    "meta":{"foo":"bar"}
    """

  Scenario: json content
    Given the Server is running at "middleman-app"
    When I go to "/test.json"
    Then I should see:
    """
    "content":"<h1>Header</h1>\n\n<p>lorem ipsum</p>\n"
    """
