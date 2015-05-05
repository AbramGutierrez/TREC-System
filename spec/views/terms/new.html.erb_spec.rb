require 'rails_helper'

RSpec.describe "terms/new", type: :view do
  before(:each) do
    assign(:term, Term.new(
      :order => 1,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new term form" do
    render

    assert_select "form[action=?][method=?]", terms_path, "post" do

      assert_select "input#term_order[name=?]", "term[order]"

      assert_select "input#term_title[name=?]", "term[title]"

      assert_select "textarea#term_body[name=?]", "term[body]"
    end
  end
end
