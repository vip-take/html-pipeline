require "test_helper"

class HTML::Pipeline::PlainTextInputFilterTest < Test::Unit::TestCase
  PlainTextInputFilter = HTML::Pipeline::PlainTextInputFilter

  def test_dependency_management
    assert_dependency "plain_text_input_filter", "escape_utils"
  end

  def test_fails_when_given_a_documentfragment
    body = "<p>heyo</p>"
    doc  = Nokogiri::HTML::DocumentFragment.parse(body)
    assert_raise(TypeError) { PlainTextInputFilter.call(doc, {}) }
  end

  def test_wraps_input_in_a_div_element
    doc = PlainTextInputFilter.call("howdy pahtner", {})
    assert_equal "<div>howdy pahtner</div>", doc.to_s
  end

  def test_html_escapes_plain_text_input
    doc = PlainTextInputFilter.call("See: <http://example.org>", {})
    assert_equal "<div>See: &lt;http://example.org&gt;</div>",
      doc.to_s
  end
end
