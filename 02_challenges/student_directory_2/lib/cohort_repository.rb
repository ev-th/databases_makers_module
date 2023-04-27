require_relative "./database_connection"
require_relative "./cohort"
require_relative "./student"

class CohortRepository

  def find_with_students(id)
    sql = "SELECT cohorts.id AS cohorts_id,
        cohorts.name AS cohorts_name,
        cohorts.starting_date AS starting_date,
        students.id AS students_id,
        students.name AS students_name
      FROM cohorts JOIN students
        ON cohorts.id = students.cohort_id
      WHERE cohorts.id = $1;"

    records = DatabaseConnection.exec_params(sql, [id])
    
    students = []
      records.each do |record|
        student = Student.new
        student.id = record["students_id"]
        student.name = record["students_name"]
        student.cohort_id = record["cohorts_id"]
        students << student
      end

    cohort = Cohort.new
    cohort.id = records.first["cohorts_id"]
    cohort.name = records.first["cohorts_name"]
    cohort.starting_date = records.first["starting_date"]
    cohort.students = students

    return cohort
  end
end