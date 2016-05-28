class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|

      t.string :username, null: false
      t.string :password, null: false, default: 'Aa1234567'
      # student - 0, teacher - 1, admin -2
      t.integer :account_type, null: false, default: 0
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :course
      t.integer :age
      # male - 0, female - 2
      t.integer :gender
      t.integer :view_count, default: 0

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end

end
