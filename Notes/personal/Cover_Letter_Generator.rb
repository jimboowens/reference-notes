# open and write to a file with ruby
puts "please enter the recipient: >"
recipient = gets.chomp
puts "please enter the company to which you are applying: >"
company = gets.chomp
companyName = company.gsub(" ","_")
puts "please enter the job for which you are applying: >"
job = gets.chomp
puts "please enter a skill you want to have highlighted in the cover letter (1 of 3): >"
skill_1 = gets.chomp
puts "please enter a skill you want to have highlighted in the cover letter (2 of 3): >"
skill_2 = gets.chomp
puts "please enter a skill you want to have highlighted in the cover letter (3 of 3): >"
skill_3 = gets.chomp
puts "Please enter your phone number for the recipient to contact you: >"
number = gets.chomp
puts "please enter an email address for the recipient to contact you: >"
email = gets.chomp
puts "please enter the name of the applicant: >"
applicant = gets.chomp

intro = String.new("Dear #{recipient},\n\nThank you for the opportunity to apply for the #{job} role at your company. After researching your business, it’s clear to me you’re looking for a candidate who can perform their responsibilities with confidence and ingenuity. I am sure you want to continue with the growth you’ve already acquired, and hope to add quality to the members to your team. I feel I have the necessary skills to do the job effectively, as well as perform above set expectations. I am very interested in being a part of the work you are doing, and am optimistic at the prospect of being able to fill a need. \n \n I have taken skills acquired in other industries and applied them with great success to this career. I am passionate about coding and critical thinking, and am excited about the possibility to contribute to #{company}'")
outtro = String.new(" success. \n\n Over the course of my career, I’ve developed a skill set directly relevant to the #{job} role for which you are hiring, including #{skill_1}, #{skill_2}, and #{skill_3}. Overall, I consistently demonstrate creative thinking, problem-solving, and teamwork abilities my training at DigitalCrafts coding bootcamp. I invite you to review my detailed qualifications in the attached resume. \n\n I believe I am the kind of competent and consistent coder you are looking to hire. At your convenience, please feel free to contact me at #{number}, or via email at #{email} to arrange a meeting time. Thank you for your consideration, and I look forward to hearing from you soon. \n\n Sincerely,\n\n #{applicant}")

open("#{companyName}_cover_letter.txt",'w') { |f|
    f << (company[-1] == "s" ? (intro + "" + outtro) : (intro + "s" + outtro))
}