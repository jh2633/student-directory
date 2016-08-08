
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #puts "We are only intaking students with Dr. titles"
  #puts "You cannot input more than 12 characters"
  @students = []
  name = STDIN.gets.chomp.capitalize

  if name == ""
    exit
  end
  #exercise 12
  #if name[0] != "D" || name.length > 12
    #exercise 2 and 3, limites initial letter and length
  #  puts "You have to have a Dr. qualification"
  #  puts "And the name cannot be more than 12 characters"
  #  name = gets.chomp
  #end

  puts "What is their hobby?"
  hobby = gets.chomp
  #exercise 5
  puts "What is their height? In cm please"
  height = gets.chomp
  #exercise 5
  puts "If they are not in the November cohort, please specify their cohort, otherwise press enter"
  cohort = gets.chomp
  #exercise 7, change cohort
  if cohort == ""
    cohort = "November"
  end
  while !name.empty? do
    @students << {name: name.capitalize, cohort: cohort, hobby: hobby, height: height}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
  #exercise 9, plural and singular student(s)
    name = STDIN.gets.chomp
    if !name.empty?

      puts "Hobby?"
      hobby = gets.chomp
      puts "Height?"
      height = gets.chomp
    end
  end
  @students
end

def header
puts "The students of Villains Academy"
puts "-------------"
end

def print_student_names
  @students.each_with_index do |student, index|
  puts "#{(index+1)}. #{student[:name]} (#{student[:cohort]} cohort)"
  #puts "Hobby: #{student[:hobby].capitalize} Height: #{student[:height]}cm"
  #added each with index, increase index by one to offset 0
  #exercise 1
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list of students and their cohort to students.csv"
  puts "4. Load the existing students file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  header
  print_student_names
  print_footer
end


def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  @students = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end
interactive_menu
