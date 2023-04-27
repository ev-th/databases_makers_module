require 'cohort_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_cohorts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do 
    reset_tables
  end

  describe "#find_with_students" do
    it "returns a cohort with a list of students" do
      repo = CohortRepository.new
      cohort = repo.find_with_students(1)
      # binding.irb

      expect(cohort.id).to eq "1"
      expect(cohort.starting_date).to eq "2023-03-15"
      expect(cohort.students.length).to eq 2
      expect(cohort.students.first.name).to eq "name_1"
      expect(cohort.students.first.cohort_id).to eq "1"
      expect(cohort.students.last.name).to eq "name_2"
      expect(cohort.students.last.cohort_id).to eq "1"

    end
  end


end