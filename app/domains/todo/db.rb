module Todo
  module DB
    def self.prepare
      if Rails.env != 'test'
        database_path = File.join(Dir.pwd, 'db', 'todo.sqlite3')

        connect_database database_path
        create_table_if_not_exists database_path
      end
    end

    def self.prepare_for_test
      database_path = File.join(Dir.pwd, 'db', 'todo_test.sqlite3')

      connect_database database_path
      create_table_if_not_exists database_path

    end

    def self.connect_database(path)
      spec = {adapter: 'sqlite3', database: path}
      ActiveRecord::Base.establish_connection spec
    end

    def self.create_table_if_not_exists(path)
      create_database_path path

      connection = ActiveRecord::Base.connection

      return if connection.table_exists?(:tasks)

      connection.create_table :tasks do |t|
        t.column :name, :string, null: false
        t.column :content, :text, null: false
        t.column :status, :integer, default: 0, null: false
        t.timestamps
      end
      connection.add_index :tasks, :status
      connection.add_index :tasks, :created_at
    end

    def self.create_database_path(path)
      FileUtils.mkdir_p File.dirname(path)
    end

    private_class_method :connect_database, :create_table_if_not_exists, :create_database_path
  end
end