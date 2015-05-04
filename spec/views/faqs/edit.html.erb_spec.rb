require 'rails_helper'

RSpec.describe "faqs/edit", type: :view do
  before(:each) do
    @faq = assign(:faq, Faq.create!(
      :order => 1,
      :question => "MyText",
      :answer => "MyText"
    ))
  end

  it "renders the edit faq form" do
    render

    assert_select "form[action=?][method=?]", faq_path(@faq), "post" do

      assert_select "input#faq_order[name=?]", "faq[order]"

      assert_select "textarea#faq_question[name=?]", "faq[question]"

      assert_select "textarea#faq_answer[name=?]", "faq[answer]"
    end
  end
end
