Feature: JSON API
  Scenario: json frontmatter
    Given the Server is running at "middleman-app"
    When I go to "/test.json"
    Then I should see:
    """
    "metadata":{"foo":"bar"}
    """
    And I should see:
    """
    "path":"/test.html"
    """

  Scenario: json content
    Given the Server is running at "middleman-app"
    When I go to "/test.json"
    Then I should see:
    """
    <h1>Header</h1>\n\n<p>lorem ipsum</p>\n
    """

  Scenario: template with no front matter
    Given the Server is running at "middleman-app"
    When I go to "/no-frontmatter.json"
    Then I should see:
    """
    <div>No Frontmatter</div>
    """

  Scenario: page with frontmatter references
    Given the Server is running at "middleman-app"
    When I go to "/frontmatter-reference.json"
    Then I should see:
    """
    <h2>foo</h2>\n
    """

  Scenario: built files
    Given a built app at "middleman-app" with flags "--verbose --clean"
    When I cd to "build"
    Then the following files should exist:
      | index.html |
      | index.json |
      | test.html |
      | test.json |
