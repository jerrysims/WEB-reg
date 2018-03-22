Course.destroy_all

courses = Course.create([
  {
    name: "General Science",
    description: "Covers science via discreet units of study with an emphasis on the scientific method and familiarization with scientific terms",
    textbooks: "N/A",
    grades: "5,6",
    day: "Tuesday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 25,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Chemistry",
    description: "Investigate the world of atoms and molecules through hands-on inquiry-based activities and molecular model animations.",
    textbooks: "Middle School Chemistry by ACS",
    grades: "6,7",
    day: "Tuesday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 75,
    class_minimum: 12,
    class_maximum: 16
  },{
    name: "American Literature",
    description: "Students will learn to develop and defend written and oral arguments through careful reading various genres in American literature. Students will spend the bulk of their in-class time improving their writing skills; students should be able to write a good paragraph with ease before taking this course.",
    textbooks: "Texts: A Break With Charity by Ann Rinaldi, Common Sense by Thomas Paine, *Big Two-Hearted River by Ernest Hemingway, *Civil Disobedience by Henry David Thoreau, March - The Trilogy by John Lewis, Homecoming by Cynthia Voigt, The Adventures of Huckleberry Finn by Mark Twain and *Poetry; *Copies of these texts to be provided by instructor.",
    grades: "6,7,8",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 15,
    class_minimum: 12,
    class_maximum: 17
  },{
    name: "HS Prep Literature",
    description: "Upon entry, students should be able to write three-paragraph essays with confidence and be able to articulate their own main ideas and compose topic sentences. Students should also be familiar with writing four-sentence paragraphs. Entering students will need to demonstrate basic reading comprehension, including deduction, prediction, and summary. Students must be ready to move beyond YA literature and should have experience with reading longer works (200+ pages). Some exposure to 19th-century texts is strongly suggested, but not required. The course will build on the above and focus on the following skills: thesis statements, moving beyond the three-paragraph essay, using textual evidence, conducting research, integrating sources, and thinking critically about literature. Additionally, due to the subject nature of some of the texts on the reading list, we will also practice how to address sensitive topics in conversation and writing.",
    textbooks: "Texts: In addition to selected poems and short stories, texts will likely include The Scarlet Letter, by Nathaniel Hawthorne; The Awakening, by Kate Chopin; Brave New World, by Aldous Huxley;The Parable of the Sower, by Octavia Butler; and The Hate U Give, by Angie Thomas. The Prentice Hall Reference Guide, 9th edition will also be required.",
    grades: "7,8,9",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 15,
    class_minimum: 12,
    class_maximum: 17
  },{
    name: "Reading for Writing",
    description: "Students should be familiar with basic parts and structures of English sentences, conventions of written English (capitalization, punctuation, indentation, etc.) and some literary devices. Students should be able to write a strong simple sentence: subject, verb, independent clause. Students should demonstrate grade level-appropriate reading comprehension and reading fluency. Students will work on the mechanics of written communication (spelling, grammar, formatting); growing comprehension and fluency as readers; learning to identify and use literary elements to communicate their own ideas. They will learn to support ideas in discussion by referencing the text and identify themes and connect them across texts. Projects will include writing personal narratives, imaginative narratives, informational material, and opinion pieces.",
    textbooks: "Texts: Hoot, by Carl Hiaasen; Homesick, by Jean Fritz; Hidden Figures Young Readers' Edition, by Margot Lee Shetterly; student’s choice of paired texts, such as The Sea of Monsters, by Rick Riordan with The Odyssey, Rosemary Sutcliffe adaptation, OR Nim’s Island, by Wendy Orr with Robinson Crusoe, by Daniel Defoe (other choices will be available). The remainder of the texts will be free choice from a curated list of books. Free choice list to be announced at the beginning of each study unit.",
    grades: "5,6",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 15,
    class_minimum: 12,
    class_maximum: 17
  },{
    name: "Award Winners Literature",
    description: "Students should be able to write a basic five-sentence paragraph with topic sentence, details, and closing sentence; basic capitalization, punctuation, indentation, etc. Students will focus on writing reading response paragraphs, one short story, one personal essay and one literary analysis essay. Reading will consist of literary award winning books.",
    textbooks: "Texts: Fall: Past Perfect, Present Tense by Richard Peck, One Last Word by Nikki Grimes, Tuck Everlasting by Natalie Babbit, Search for Delicious by Natalie Babbit; Spring: Witch of Blackbird Pond by Elizabeth George Speare, Sign of the Beaver by Elizabeth George Speare, Roll of Thunder, Hear my Cry by Mildred D. Taylor, A Wrinkle in Time by Madeleine L’Engle, The Old Man and the Sea by Ernest Hemingway, Wonder by R.J. Palacio",
    grades: "5,6,7",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 15,
    class_minimum: 12,
    class_maximum: 17
  },{
    name: "Biology",
    description: "Students will investigate and make sense of phenomena and models, develop, analyze, and critique explanations and apply or extend science ideas and practices to new phenomena.",
    textbooks: "",
    grades: "7,8",
    day: "Tuesday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 50,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Physical Science",
    description: "Students will learn about mechanics, heat, electricity, atomic structure, astronomy and more.",
    textbooks: "Derek Owens Physical Science",
    grades: "7,8",
    day: "Tuesday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 95,
    class_minimum: 12,
    class_maximum: 20
  },{
    name: "Art/History",
    description: "This course seeks to immerse students in the visual history of the human experience through tactile and experiential application. Classes will alternate between lectures offering historical glimpses into mankind’s creative past and workshops wherein student’s will develop their own expressive skills.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 70,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Applied Science",
    description: "Students will focus on creating their own science fair project during the first semester, with class time devoted to the application of the scientific method and presenting findings. Second semester, students will learn about fields of applied science as well as careers in the sciences.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Tuesday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 30,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Creative Writing",
    description: "Designed to give students the opportunity to think and write creatively through studying various genres. Students will be encouraged to foster the necessary habits of any good writer: discipline, observation and developing a good ear for dialogue.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Tuesday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 0,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Sewing & Knitting",
    description: "Designed to teach students textile and yarn arts for practical repairs, gifts, and relaxation.  Students will learn a variety of construction and embellishment techniques in both yarn and fabric.  They will share their new skills through service projects and a collaborative WEB Tutorial exhibit.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Tuesday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 55,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Middle School Math (7th)",
    description: "Will cover the topics normally covered in a middle school 7th grade math course. This course is designed to prepare students for Pre-Algebra.",
    textbooks: "N/A",
    grades: "6,7,8",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 50,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Pre AP History",
    description: "An advanced preparatory course that will focus on the following: contextualizing and synthesizing historical documents; understanding differences between primary and secondary documents; responding to DBQs (data-based-questions); practicing reasoning skills of contextualization, comparison, causation, continuity and change over time, as per AP History guidelines. The syllabus is rigorous and students should be prepared to work diligently outside of class on heavy reading and writing assignments. Historical periods will cover the Age of Discovery through World War II.",
    textbooks: "Required texts (tentative): The Narrative of the Life of Frederick Douglass. The Prentice Hall Reference Guide, 9th edition (if also enrolled in HS Prep Lit, only one copy is required). A Class Pack will be provided.",
    grades: "7,8,9",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    fee: 50,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Geography",
    description: "This geography course will teach students how to label and study detailed maps of the world using the curriculum Mapping the World by Heart by David Smith.",
    textbooks: "Mapping the World by Heart, The Geography Coloring Book",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 50,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Intro to Spanish",
    description: "Designed to give the novice second-language student a taste of the Spanish speaking world, while making the language accessible and comprehensible.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 0,
    class_minimum: 12,
    class_maximum: 20
  },{
    name: "American History",
    description: "Designed to give students an overall view of American History from Colonial to Present. This course is designed to familiarize students with American History terms and key players that will be encountered in High School American History courses.",
    textbooks: "TBD",
    grades: "5,6,7",
    day: "Thursday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 50,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Pre Algebra",
    description: "Will cover the topics normally covered in a middle school prealgebra course. This course is designed to prepare students for Algebra 1.",
    textbooks: "N/A",
    grades: "6,7,8,9",
    day: "Thursday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 50,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Spanish 1",
    description: "Designed to introduce students to the Spanish language and its associated cultures.  The purpose of the course is to communicate in Spanish, understand other cultures, connect with other disciplines and acquire information, develop insight into one’s own language and culture, and to participate in the global community.",
    textbooks: "Avencemos",
    grades: "7,8,9",
    day: "Thursday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 100,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Studio Art/Portfolio Prep",
    description: "This course is designed to encourage and support students in the development of their unique creative voice. An emphasis will be placed on traditional studio development in drawing, painting, sculpting, photography, and printmaking. Students will learn about constructive art criticism in a supportive and nurturing environment while developing their confidence and technical skills with composition, perception, color theory, figure drawing, shape, and form. The course will culminate in a portfolio collection and curated gallery exhibition.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "11:30",
    end_time: "13:00",
    fee: 100,
    class_minimum: 10,
    class_maximum: 12
  },{
    name: "Studio Art/Portfolio Prep",
    description: "This course is designed to encourage and support students in the development of their unique creative voice. An emphasis will be placed on traditional studio development in drawing, painting, sculpting, photography, and printmaking. Students will learn about constructive art criticism in a supportive and nurturing environment while developing their confidence and technical skills with composition, perception, color theory, figure drawing, shape, and form. The course will culminate in a portfolio collection and curated gallery exhibition.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 100,
    class_minimum: 10,
    class_maximum: 12
  },{
    name: "Spanish Conversation",
    description: "Designed to allow students in Intro to Spanish or Spanish 1 practice their Spanish conversation skills. This course can also follow Spanish 1 to expand conversational skills and can be taken concurrently with a Spanish 2 course online or outside of WEB.",
    textbooks: "N/A",
    grades: "6,7,8,9",
    day: "Thursday",
    start_time: "13:00",
    end_time: "14:30",
    fee: 0,
    class_minimum: 10,
    class_maximum: 15
  }])

p "Created #{Course.count} courses"

# --- END COURSE SEEDS ---

# ---  BEGIN PRODUCT SEEDS ---

Product.destroy_all

products = Product.create([
  {
    name: "2018/2019 Class Tuition-Monthly",
    unit_price: 55
  },{
    name: "2018/2019 Class Tuition-Annual",
    unit_price: 410 
  },{
    name: "2018/2019 Class Tuition-Semester",
    unit_price: 205
  },{
    name: "2018/2019 Registration",
    unit_price: 100
  },{
    name: "2018/2019 Study Hall - Monthly",
    unit_price: 28
  },{
    name: "2018/2019 Study Hall-Semester",
    unit_price: 100
  },{
    name: "Applied Science Class Fee",
    unit_price: 30,
    courses: Course.where(name: ["Applied Science"] )
  },{
    name: "Art/Hist Class Fee",
    unit_price: 70,
    courses: Course.where(name: ["Art/History"] )
  },{
    name: "Biology Class Fee",
    unit_price: 50,
    courses: Course.where(name: ["Biology"] )
  },{
    name: "Chemistry Class fee",
    unit_price: 75,
    courses: Course.where(name: ["Chemistry"] )
  },{
    name: "Family Registration Discount",
    unit_price: -50
  },{
    name: "General Science class fee",
    unit_price: 25,
    courses: Course.where(name: ["General Science"] )
  },{
    name: "Geography Class Fee",
    unit_price: 20,
    courses: Course.where(name: ["Geography"] )
  },{
    name: "Late Registration Fee",
    unit_price: 50
  },{
    name: "Middle School Math fee",
    unit_price: 50,
    courses: Course.where(name: ["Middle School Math (7th)"] )
  },{
    name: "Physical Science Class Fee",
    unit_price: 95,
    courses: Course.where(name: ["Physical Science"] )
  },{
    name: "PreAlgebra Class fee",
    unit_price: 95,
    courses: Course.where(name: ["Pre Algebra"] )
  },{
    name: "HS Prep Literature Class fee",
    unit_price: 15,
    courses: Course.where(name: ["HS Prep Literature"] )
  },{
    name: "Award Winners Literature Class fee",
    unit_price: 15,
    courses: Course.where(name: ["Award Winners Literature"] )
  },{
    name: "Reading for Writing Class fee",
    unit_price: 15,
    courses: Course.where(name: ["Reading for Writing"] )
  },{
    name: "Sewing & Knitting Class Fee",
    unit_price: 55,
    courses: Course.where(name: ["Sewing & Knitting"] )
  },{
    name: "American History Class fee",
    unit_price: 50,
    courses: Course.where(name: ["American History"] )
  },{
    name: "Pre AP History Class fee",
    unit_price: 50,
    courses: Course.where(name: ["Pre AP History"] )
  },{
    name: "Spanish 1 Class fee",
    unit_price: 100,
    courses: Course.where(name: ["Spanish 1"] )
  },{
    name: "American Literature Class fee",
    unit_price: 15,
    courses: Course.where(name: ["American Literature"] )
  },{
    name: "Studio Art class fee",
    unit_price: 100,
    courses: Course.where(name: ["Studio Art/Portfolio Prep"] )
  }])

  p "Created #{Product.count} products"

  # --- END PRODUCT SEEDS ---
