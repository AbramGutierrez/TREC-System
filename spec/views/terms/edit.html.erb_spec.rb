require 'rails_helper'

RSpec.describe "terms/edit", type: :view do
  before(:each) do
    @term = assign(:term, Term.create!(
      :order => 1,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit term form" do
    render

    assert_select "form[action=?][method=?]", term_path(@term), "post" do

      assert_select "input#term_order[name=?]", "term[order]"

      assert_select "input#term_title[name=?]", "term[title]"

      assert_select "textarea#term_body[name=?]", "term[body]"
    end
  end
end
