class AddGradeEvalutionToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :grade_evalution, :float
  end
end
