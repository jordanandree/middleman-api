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

  Scenario: built files
    Given a built app at "middleman-app" with flags "--verbose --clean"
    When I cd to "build"
    Then the following files should exist:
      | index.html |
      | index.json |
      | test.html |
      | test.json |
      | tilt/liquid.html |
      | tilt/liquid.json |
      | tilt/markdown.html |
      | tilt/markdown.json |
      | tilt/rdoc.html |
      | tilt/rdoc.json |
      | tilt/slim.html |
      | tilt/slim.json |
      | tilt/textile.html |
      | tilt/textile.json |
