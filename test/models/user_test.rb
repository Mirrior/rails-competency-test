require "test_helper"

describe User do
  let(:user) { users(:valid) }
  let(:editor) { users(:editor) }

  it "must be valid" do
    user.must_be :valid?
  end

  describe "with a role of editor" do
    it "must be valid" do
      editor.must_be :valid?
    end

    it "must have a role of editor" do
      assert_includes(editor.roles, :editor, "Editor does not have editor role")
    end
  end
end
