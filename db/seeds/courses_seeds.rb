Course.destroy_all

courses = Course.create([
  {
    name: "Gen Science",
    description: "Covers science via discreet units of study with an emphasis on the scientific method and familiarization with scientific terms",
    textbooks: "N/A",
    grades: "5,6",
    day: "Tuesday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 25,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Chemistry",
    description: "Investigate the world of atoms and molecules through hands-on inquiry-based activities and molecular model animations.",
    textbooks: "Middle School Science",
    grades: "5,6,7",
    day: "Tuesday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 50,
    class_minimum: 12,
    class_maximum: 16
  },{
    name: "American Lit",
    description: "Designed for students who have mastered personal essay writing and identifying themes; will focus on three paragraph essays and digging deeper into American Literature texts",
    textbooks: "",
    grades: "6,7,8",
    day: "Tuesday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "HS Prep Lit",
    description: "Designed for students who have three paragraph essays and connecting themes in literature; will focus heavily on a wide range of writing and digging deeper into classic literature texts",
    textbooks: "",
    grades: "7,8,9",
    day: "Tuesday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 20
  },{
    name: "Classic Lit",
    description: "Designed for students who can read independently and write a strong sentence; will focus on paragarph writing and discussion of fairy tales and myths",
    textbooks: "",
    grades: "5,6",
    day: "Tuesday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Award Winners Lit",
    description: "Designed for students who can write a strong paragraph and understand plot and detail when reading independently; will focus on writing personal essays and reading literary award winning books",
    textbooks: "",
    grades: "5,6,7",
    day: "Tuesday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Biology",
    description: "Students will investigate and make sense of phenomena and models, develop, analyze, and critique explanations and apply or extend science ideas and practices to new phenomena.",
    textbooks: "Toward High School Biology",
    grades: "7,8",
    day: "Tuesday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 50,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Physical Science",
    description: "Students will learn about mechanics, heat, electricity, atomic structure, astronomy and more.",
    textbooks: "Derek Owen's Physical Science",
    grades: "7,8",
    day: "Tuesday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 125,
    class_minimum: 12,
    class_maximum: 20
  },{
    name: "Art/History",
    description: "This course seeks to immerse students in the visual history of the human experience through tactile and experiential application. Classes will alternate between lectures offering historical glimpses into mankind’s creative past and workshops wherein student’s will develop their own expressive skills.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Tuesday",
    start_time: "13:20",
    end_time: "14:45",
    fee: 70,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Applied Science",
    description: "Students will focus on creating their own science fair project during the first semester, with class time devoted to the application of the scientific method and presenting findings. Second semester, students will learn about fields of applied science as well as careers in the sciences.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Tuesday",
    start_time: "13:20",
    end_time: "14:45",
    fee: 35,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Creative Writing",
    description: "Designed to give students the opportunity to think and write creatively through studying various genres. Students will be encouraged to foster the necessary habits of any good writer: discipline, observation and developing a good ear for dialogue.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Tuesday",
    start_time: "13:20",
    end_time: "14:45",
    fee: 0,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Algebra 1",
    description: "Will cover the topics normally covered in a first year high school algebra course, including equations, polynomials, factoring, functions, inequalities and quadratic functions.",
    textbooks: "Derek Owen's Algebra 1",
    grades: "7,8,9",
    day: "Tuesday",
    start_time: "13:20",
    end_time: "14:45",
    fee: 50,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "MS Math",
    description: "N/A",
    textbooks: "",
    grades: "6,7,8",
    day: "Thursday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Pre AP History",
    description: "N/A",
    textbooks: "",
    grades: "7,8,9",
    day: "Thursday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Geography",
    description: "This geography course will teach students how to label and study detailed maps of the world using the curriculum Mapping the World by Heart by David Smith.",
    textbooks: "Mapping the World by Heart, The Geography Coloring Book",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 50,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Intro to Spanish",
    description: "Designed to give the novice second-language student a taste of the Spanish speaking world, while making the language accessible and comprehensible.",
    textbooks: "N/A",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "9:45",
    end_time: "11:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 20
  },{
    name: "American History",
    description: "N/A",
    textbooks: "",
    grades: "5,6,7",
    day: "Thursday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 0,
    class_minimum: 12,
    class_maximum: 18
  },{
    name: "Pre Algebra",
    description: "Will cover the topics normally covered in a middle school prealgebra course. This course is designed to prepare students for Algebra 1.",
    textbooks: "",
    grades: "6,7,8,9",
    day: "Thursday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 50,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Spanish 1",
    description: "Designed to introduce students to the Spanish language and its associated cultures.  The purpose of the course is to communicate in Spanish, understand other cultures, connect with other disciplines and acquire information, develop insight into one’s own language and culture, and to participate in the global community.",
    textbooks: "Avencemos",
    grades: "7,8,9",
    day: "Thursday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 100,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Studio Art/Portfolio Prep",
    description: "N/A",
    textbooks: "",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "11:45",
    end_time: "13:15",
    fee: 100,
    class_minimum: 10,
    class_maximum: 12
  },{
    name: "Studio Art/Portfolio Prep",
    description: "N/A",
    textbooks: "",
    grades: "5,6,7,8",
    day: "Thursday",
    start_time: "13:20",
    end_time: "14:45",
    fee: 100,
    class_minimum: 10,
    class_maximum: 12
  },{
    name: "MS Math",
    description: "N/A",
    textbooks: "",
    grades: "6,7,8",
    day: "Thursday",
    start_time: "13:20",
    end_time: "14:45",
    fee: 0,
    class_minimum: 12,
    class_maximum: 15
  },{
    name: "Spanish Conversation",
    description: "Designed to allow students in Intro to Spanish or Spanish 1 practice their Spanish conversation skills.",
    textbooks: "N/A",
    grades: "6,7,8,9",
    day: "Thursday",
    start_time: "1:20",
    end_time: "14:45",
    fee: 0,
    class_minimum: 10,
    class_maximum: 15
  }])

  p "Created #{Course.count} courses"
