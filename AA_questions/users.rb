require_relative "questions.rb"
require_relative "question_follows.rb"
require_relative "replies.rb"



class Users
    attr_accessor :fname, :lname
    attr_reader :id
    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id) 
			SELECT
				*
			FROM
				users
			WHERE
				id = ?
		SQL
		Users.new(user.first) 
    end
    
    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance,execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?
                AND
                lname = ?
        SQL
        Users.new(user.first) 
    end

    def initialize(options)
		@id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Question.find_by_author_id(id)

    end

end