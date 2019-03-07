Course.destroy_all

courses = Course.create([
  {
    name: "Algebra 1",
    description: "Will cover the topics normally covered in a high school Algebra course. This course is designed to qualify for a high school math credit in Algebra 1 and meets on Tuesdays AND Thursdays.",
    grades: "7,8,9",
    suggested_grade: "8",
    subject_area: "Math",
    textbooks: "MathLight Algebra",
    day: "Tuesday/Thursday",
    start_time: "14:15",
    end_time: "15:15",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "American Lit",
    description: "Designed for students who have mastered personal essay writing and identifying themes; this course will focus on a variety of writing assignments, including three and five paragraph essays as well as one longer research project in the spring. Students will gain practice in close reading texts and developing a deeper understanding of the American culture through a broad range of texts. Previous books for this course have included A Break With Charity, The Lottery, March and Civil Disobedience.",
    grades: "6,7,8",
    suggested_grade: "7",
    subject_area: "Literature",
    textbooks: "To Be Finalized",
    day: "Tuesday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Anatomy & Physiology",
    description: "Anatomy and physiology will cover the structure and function of all of the major body systems, primarily through problem based learning and role playing.",
    grades: "7,8,9",
    suggested_grade: "7,8,9",
    subject_area: "Science",
    textbooks: "Diagnosis for Classroom Success: Making Anatomy and Physiology Come Alive",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Applied Science",
    description: "Students will focus on creating their own science fair project during the first semester, with class time devoted to the application of the scientific method and presenting findings. Second semester, students will learn about fields of applied science as well as careers in the sciences.",
    grades: "5,6,7",
    suggested_grade: "5,6,7",
    subject_area: "Science",
    textbooks: "n/a",
    day: "Tuesday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Award Winning Lit",
    description: "Designed for students who can write a strong paragraph and understand plot and detail when reading independently; will focus on writing personal essays. Book selections will be literary award winning books. Previous texts for this course have included Wonder, Tuck Everlasting, The Search for Delicious, A Wrinkle in Time and The Old Man and the Sea.",
    grades: "5,6,7",
    suggested_grade: "6",
    subject_area: "Literature",
    textbooks: "To Be Finalized",
    day: "Tuesday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Biology",
    description: "Students will investigate and make sense of phenomena and models, develop, analyze, and critique explanations and apply or extend science ideas and practices to new phenomena.",
    grades: "7,8",
    suggested_grade: "7",
    subject_area: "Science",
    textbooks: "To Be Finalized",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Chemistry",
    description: "Investigate the world of atoms and molecules through hands-on inquiry-based activities and molecular model animations.",
    grades: "5,6,7",
    suggested_grade: "6",
    subject_area: "Science",
    textbooks: "Middle School Chemitstry by ACS",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Gen Science",
    description: "Covers science via discreet units of study with an emphasis on the scientific method and familiarization with scientific terms. Units will include scientific method, life sciences, human anatomy and physiology, earth/space sciences, chemistry and physics.",
    grades: "5,6",
    suggested_grade: "5",
    subject_area: "Science",
    textbooks: "Classroom Complete Press Middle School Bundle OR Everything You Need to Ace Science in One Big Fat Notebook",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Geography",
    description: "This geography course will teach students how to label and study detailed maps of the world using the curriculum Mapping the World by Heart by David Smith.",
    grades: "5,6,7",
    suggested_grade: "5,6,7",
    subject_area: "Social Studies",
    textbooks: "Mapping the World by Heart, Geography Coloring Book",
    day: "Thursday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "HS Prep Lit",
    description: "Designed around a year-long theme of Magic & Monsters, this class will examine various ways in which human beings engage with their fears and discomforts on the written page. We will address questions such as: Why do we invent monsters, and what do their attributes tell us about the things people fear? How do authors use the device of magic to combat fictional monsters, and what can the bravery of fictional characters teach us about our own courage? Appropriate for students who are comfortable writing three paragraph essays and connecting themes in literature; will focus heavily on a wide range of writing and digging deeper into various types of texts. Texts are being finalized but may include Man’s Search For Meaning by Viktor Frankl, A Monster Calls by Patrick Ness, The Neverending Story by Michael Ende, and Gregor the Overlander by Suzanne Collins.",
    grades: "7,8,9",
    suggested_grade: "8",
    subject_area: "Literature",
    textbooks: "To Be Finalized",
    day: "Tuesday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Intro to Spanish",
    description: "Designed to give the novice second-language student a taste of the Spanish speaking world, while making the language accessible and comprehensible.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Spanish",
    textbooks: "Señor Wooly and Garbanzo",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "MS Math",
    description: "Will cover the topics normally covered in a middle school 7th grade math course. This course is designed to prepare students for Pre-Algebra and meets on Tuesdays AND Thursdays.",
    grades: "6,7,8",
    suggested_grade: "7",
    subject_area: "Math",
    textbooks: "Saxon 7/6",
    day: "Tuesday/Thursday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Physical Science",
    description: "Students will learn about mechanics, heat, electricity, atomic structure, astronomy and more. Students should be enrolled in at least Pre-Algebra math concurrently. (Math does not have to be taken at WEB.)",
    grades: "7,8",
    suggested_grade: "8",
    subject_area: "Science",
    textbooks: "Derek Owens Physical Science",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Pop Music Appreciation",
    description: "This class covers the history of American popular music, beginning with the invention of radio and gramophone recordings and extending all the way to the modern day. From Johnny Cash to Kurt Cobain, Bob Dylan to Britney Spears, students are exposed to a multitude of genres and learn the connection between technology, politics, social issues, and music.",
    grades: "5,6,7,8,9",
    suggested_grade: "5,6,7,8",
    subject_area: "Elective",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 18
  },{
    name: "Pre Algebra",
    description: "Will cover the topics normally covered in a middle school prealgebra course. This course is designed to prepare students for Algebra 1 and meets on Tuesdays AND Thursdays.",
    grades: "6,7,8,9",
    suggested_grade: "8",
    subject_area: "Math",
    textbooks: "MathLight PreAlgebra",
    day: "Tuesday/Thursday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Psychology",
    description: "A general introduction to the fundamental elements and major approaches to Psychology. We will address topics such as personality theory, brain development and function and more. Students will participate in interactive labs, and will potentially (depending on time) have the opportunity to design an experiment of their own. This class is recommended for 7th grade and up.",
    grades: "7,8,9",
    suggested_grade: "7,8,9",
    subject_area: "Science",
    textbooks: "Psych101 by Paul Kleinman",
    day: "Thursday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Reading for Writing",
    description: "Students will read a variety of works by #OwnVoices authors, which will serve as models for the mechanics of written communication (spelling, grammar, formatting). Students should be able to write a strong sentence, and should be familiar with the conventions of written English (capitalization, punctuation, indentation, etc.). Projects will include writing personal narratives, imaginative narratives, informational material, and opinion pieces. The reading list for this course is still being finalized; previous titles have included Hidden Figures Young Readers Edition, Homesick, Rosemary Sutcliff’s adaptation of The Odyssey, and Nim’s Island.",
    grades: "5,6",
    suggested_grade: "5",
    subject_area: "Literature",
    textbooks: "To Be Finalized",
    day: "Tuesday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 16
  },{
    name: "Sewing & Knitting",
    description: "Designed to teach students textile and yarn arts for practical repairs, gifts and relaxation.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Elective",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Studio Art 1",
    description: "Studio 1 is designed to encourage and support students in their unique creative journey. An emphasis will be placed on traditional studio development with a strong focus on realistic drawing skills, observational drawing practice, 3 dimensional shading, multi-point perspectives, and figure drawing. Recommended for previous WEB art students OR 7th and 8th grade students.",
    grades: "6,7,8",
    suggested_grade: "6,7,8",
    subject_area: "Elective",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 10,
    class_maximum: 12
  },{
    name: "Studio Art 2",
    description: "Studio 2 provides a space for artistically motivated, driven and experienced students who are ready to undertake new creative challenges in an independent work environment. During this studio course students will focus on defining their unique artistic voice while learning how to provide, process and utilize constructive feedback in a supportive and nurturing community of fellow artists. Studio 2 prerequisite requirement: Completion of WEB Studio 1 with teacher recommendation OR personal portfolio submission plus interview with the instructor demonstrating a variety of creative material familiarity and comfort.",
    grades: "6,7,8",
    suggested_grade: "6,7,8",
    subject_area: "Elective",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 10,
    class_maximum: 12
  },{
    name: "Studio Fundamentals",
    description: "An introduction to the creative tools and materials that provide a foundation in the fine arts. Learn the basics of visual communication by developing 2 and 3 dimensional drawing skills while also receiving instruction in color theory techniques and vocabulary, oil pastels, watercolor and acrylic painting, printmaking, an introduction to ceramic sculpture, and so much more. This class serves as a prerequisite fulfillment for WEB Art Studio 1.",
    grades: "6,7,8,9",
    suggested_grade: "5,6,7,8",
    subject_area: "Elective",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 10,
    class_maximum: 15
  },{
    name: "Study Hall",
    description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Study",
    textbooks: "n/a",
    day: "Tuesday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 0,
    class_maximum: 6
  },{
    name: "Study Hall",
    description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Study",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 0,
    class_maximum: 6
  },{
    name: "Study Hall",
    description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Study",
    textbooks: "n/a",
    day: "Tuesday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 0,
    class_maximum: 6
  },{
    name: "Study Hall",
    description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Study",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "11:35",
    end_time: "13:05",
    class_minimum: 0,
    class_maximum: 6
  },{
    name: "Study Hall",
    description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Study",
    textbooks: "n/a",
    day: "Tuesday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 0,
    class_maximum: 6
  },{
    name: "Study Hall",
    description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Study",
    textbooks: "n/a",
    day: "Thursday",
    start_time: "9:30",
    end_time: "11:00",
    class_minimum: 0,
    class_maximum: 6
  },{
    name: "Yearbook/Creative Writing",
    description: "Designed to give students the opportunity to think and write creatively through studying various genres. Students will be encouraged to foster the necessary habits of any good writer: discipline, observation and developing a good ear for dialogue.",
    grades: "5,6,7,8",
    suggested_grade: "5,6,7,8",
    subject_area: "Elective",
    textbooks: "Yearbook Curriculum by Julie Faulkner",
    day: "Tuesday",
    start_time: "13:10",
    end_time: "14:10",
    class_minimum: 10,
    class_maximum: 15
  }])

  p "Created #{Course.count} courses"

Product.destroy_all

products = Product.create([
  {
    name: "Registration Fee",
    product_type: "registration",
    unit_price: 150,
  },{
    name: "Sibling Discount",
    product_type: "registration",
    unit_price: -50,
  },{
    name: "Administrative Fee",
    product_type: "registration",
    unit_price: 200,
  },{
    name: "Class Tuition - Monthly",
    product_type: "tuition",
    unit_price: 66,
  },{
    name: "Class Tuition - Annual",
    product_type: "tuition",
    unit_price: 500,
  },{
    name: "Class Tuition - Semester",
    product_type: "tuition",
    unit_price: 250,
  },{
    name: "Math Class Tuition - Monthly",
    product_type: "tuition",
    unit_price: 99,
  },{
    name: "Math Class Tuition - Annual",
    product_type: "tuition",
    unit_price: 750,
  },{
    name: "Math Class Tuition - Semester",
    product_type: "tuition",
    unit_price: 375,
  },{
    name: "Study Hall Tuition - Monthly",
    product_type: "tuition",
    unit_price: 33,
  },{
    name: "Study Hall Tuition - Annual",
    product_type: "tuition",
    unit_price: 125,
  },{
    name: "Study Hall Tuition - Semester",
    product_type: "tuition",
    unit_price: 250,
  },{
    courses: Course.where(name: ["Algebra 1"]),
    name: "Algebra 1",
    unit_price: 50,
    product_type: "fee"
  },{
    courses: Course.where(name: ["American Lit"]),
    name: "American Lit",
    unit_price: 10,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Anatomy & Physiology"]),
    name: "Anatomy & Physiology",
    unit_price: 30,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Applied Science"]),
    name: "Applied Science",
    unit_price: 30,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Award Winning Lit"]),
    name: "Award Winning Lit",
    unit_price: 10,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Biology"]),
    name: "Biology",
    unit_price: 35,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Chemistry"]),
    name: "Chemistry",
    unit_price: 60,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Gen Science"]),
    name: "Gen Science",
    unit_price: 45,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Geography"]),
    name: "Geography",
    unit_price: 45,
    product_type: "fee"
  },{
    courses: Course.where(name: ["HS Prep Lit"]),
    name: "HS Prep Lit",
    unit_price: 10,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Intro to Spanish"]),
    name: "Intro to Spanish",
    unit_price: 30,
    product_type: "fee"
  },{
    courses: Course.where(name: ["MS Math"]),
    name: "MS Math",
    unit_price: 30,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Physical Science"]),
    name: "Physical Science",
    unit_price: 100,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Pop Music Appreciation"]),
    name: "Pop Music Appreciation",
    unit_price: 15,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Pre Algebra"]),
    name: "Pre Algebra",
    unit_price: 40,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Psychology"]),
    name: "Psychology",
    unit_price: 10,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Reading for Writing"]),
    name: "Reading for Writing",
    unit_price: 20,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Sewing & Knitting"]),
    name: "Sewing & Knitting",
    unit_price: 75,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Studio Art 1"]),
    name: "Studio Art 1",
    unit_price: 75,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Studio Art 2"]),
    name: "Studio Art 2",
    unit_price: 75,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Studio Fundamentals"]),
    name: "Studio Fundamentals",
    unit_price: 60,
    product_type: "fee"
  },{
    courses: Course.where(name: ["Yearbook/Creative Writing"]),
    name: "Yearbook/Creative Writing",
    unit_price: 15,
    product_type: "fee"
  },{
    name: "Scholarship Donation",
    product_type: "donation",
    unit_price: 1
  },{
    name: "Program Donation",
    product_type: "donation",
    unit_price: 1
  }])

  p "Created #{Product.count} products"
