Feature: XML API
  Scenario: xml frontmatter
    Given the Server is running at "middleman-app"
    When I go to "/test.xml"
    Then I should see:
    """
      <metadata>
        <foo>bar</foo>
      </metadata>
    """
    And I should see:
    """
      <path>/test.html</path>
    """

  Scenario: xml content
    Given the Server is running at "middleman-app"
    When I go to "/test.xml"
    Then I should see:
    """
    &lt;h1&gt;Header&lt;/h1&gt;

    &lt;p&gt;lorem ipsum&lt;/p&gt;
    """

  Scenario: template with no front matter
    Given the Server is running at "middleman-app"
    When I go to "/no-frontmatter.xml"
    Then I should see:
    """
    &lt;div&gt;No Frontmatter&lt;/div&gt;
    """

  Scenario: built files
    Given a built app at "middleman-app" with flags "--verbose --clean"
    When I cd to "build"
    Then the following files should exist:
      | index.xml |
      | test.xml |
      | tilt/liquid.xml |
      | tilt/markdown.xml |
      | tilt/rdoc.xml |
      | tilt/slim.xml |
      | tilt/textile.xml |
      | tilt/haml.xml |
