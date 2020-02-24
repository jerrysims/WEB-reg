Course.destroy_all

courses = Course.create([
  {
name: "Advanced Science Survey",
description: "The purpose of Advanced Science Survey is to cover subjects ranging from ecology, chemistry, biology and physics at a deeper dive. The course is designed for rising 7th and 8th graders who are new to WEB. Within biology, we will cover topics ranging from cell structure, photosynthesis/cell respiration, Mendel’s laws of heredity, population biology, DNA and some basic human anatomy. Within physics, we will cover topics including Newton’s three laws, temperature/heat, energy transfer, motion and simple machines. Within chemistry, we will discuss molecules, density, chemical bond formation, the periodic table, and physical and chemical changes of matter. Students will also practice science writing through lab reports, and reading comprehension via in-class discussion. If there are any questions about topics that will/will not be covered, please feel free to contact Sarah Naguib at sarah.naguib@vanderbilt.edu",
grades: "7,8",
suggested_grade: "7,8",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Algebra",
description: "Will cover the topics normally covered in a high school Algebra course. This course is designed to qualify for a high school math credit in Algebra 1 and meets on Tuesdays AND Thursdays.",
grades:  "8,9,10",
suggested_grade: "8-12; Pre-Algebra is a pre-requisite",
day: "Tuesday/Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 11,
class_maximum: 15
},{
name: "American Lit",
description: "Designed for students who want to hone their writing skills while taking a deep dive into American literature and the cultural and historical contexts that influenced it. Assignments include in-class writing, online discussion threads, and longer essays and reports. Reading assignments will run the gamut encompassing short stories, historical documents, graphic novels and classic literature.",
grades: "6,7,8",
suggested_grade: "7",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "Award Winning Lit",
description: "Designed for students who can write a strong paragraph and understand plot and detail when reading independently; will focus on writing personal essays. Book selections will be literary award winning books. Previous texts for this course have included Wonder, Tuck Everlasting, The Search for Delicious, A Wrinkle in Time and The Old Man and the Sea.",
grades: "6,7",
suggested_grade: "6",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "Bio",
description: "In this class, students will explore the diverse realm of biology on a microscopic and macroscopic level: from reptiles to algae, proteins to DNA, photosynthesis to cellular metabolism. Students will perform hands-on experiments to validate crucial principles of biology themselves; these experiments will be supplemented with further training of the scientific method, including building hypothesis, experimental design, lab notebook keeping, making predictions, interpreting data, and critical thinking. Students will have in-class assessments, exams, projects, and an end of the year presentation.",
grades: "7,8",
suggested_grade: "7",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Chem",
description: "Investigate the world of atoms and molecules through hands-on inquiry-based activities and molecular model animations. Textbook included in class fee",
grades: "6,7",
suggested_grade: "6",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Creative Writing/Yearbook",
description: "Two classes in one! Students will spend time working on their writing skills both in class and out. We’ll study the structure of story as well as character and plot development and how important they are to a good story. Alongside their writing and few reading assignments, students will serve as the design and editorial team for the WEB yearbook. Themes, photos, written copy—all will be done by the students to put out a stellar memory maker.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Eye Witness to History",
description: "Focuses on the story part of history from a child’s-eye view. Course themes will include migration and statelessness; religious integration; economic forces; warfare and conflict; innovations in technology; and the cultural responses to historical events that continue to shape the world we live in today. Textbook to be purchased by parents: A Littie History of the World by EH Gombrich.",
grades: "5,6",
suggested_grade: "5,6",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "Gen Sci",
description: "Covers science via discreet units of study with an emphasis on the scientific method and familiarization with scientific terms. Units will include scientific method, life sciences, human anatomy and physiology, earth/space sciences, chemistry and physics.",
grades: "5,6",
suggested_grade: "5",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Genre Book Club",
grades: "6,7,8",
suggested_grade: "6-8",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "Grammar/Spelling",
grades: "5,6,7",
suggested_grade: "5-7",
day: "Tuesday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11,
class_maximum: 15
},{
name: "How to Learn a Language",
description: "A beginning language student's introduction to learning a foreign language: students will be exposed to several Romance languages and learn how to study a new language and culture.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Tuesday/Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 11,
class_maximum: 15
},{
name: "HS 2D Art & Design",
description: "What makes a compelling composition? Why do some images hold our attention longer than others? How does an artist create a captivating design? Students in this course will explore these questions and more as they analyze effective designs in fine art and advertising and practice applying these methods in the studio and beyond. This class emphasizes the organization, function and manipulation of traditional design principles and elements within the two-dimensional arts of drawing, painting, printmaking and photography. Students enrolled in 2D Art & Design should be prepared to conduct independent research and document their sustained investigative process as they experiment with various creative methods throughout the course. 2D Art & Design will culminate in a portfolio collection based on advanced placement standards.",
grades: "9,10",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11
},{
name: "HS Bio",
description: "This course will give students a general introduction to a range of topics including basic biological concepts, the chemistry of life, cell structure, cell cycle, genetics, human genetics and biotechnology. Studied topics will incorporate current ethical/social commentary around biology and modern science. Students will learn how science works in the real world and discuss the differences between ""pure"" science and ""popular"" science. This class will meet the Tennessee high school graduation requirement for biology with a lab and is a prerequisite for upper level science classes at WEB.",
grades: "9,10",
suggested_grade: "9",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "HS Chem",
description: "Students will learn traditional chemistry topics within the context of societal issues and real-world scenarios. Topics of materials science, environmental chemistry, organic chemistry, biochemistry, and industrial chemistry will be explored through the use of integrative, hands-on laboratory procedures.",
grades: "10,11,12",
suggested_grade: "10-up; HS Biology is a pre-requisite",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "HS French",
description: "Designed to introduce beginner students to the French language. A communicative approach is taken to gain skills in speaking, comprehension, reading and writing. This course is designed to qualify for a high school language credit and meets on Tuesdays AND Thursdays.",
grades: "8.9.10,11,12",
suggested_grade: "8-12",
day: "Tuesday/Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11
},{
name: "HS Geometry",
description: "Will cover the topics normally covered in a high school Geometry course. This course is designed to qualify for a high school math credit in Geometry and meets on Tuesdays AND Thursdays.",
grades:  "9,10,11,12",
suggested_grade: "9-up; Algebra I is a pre-requisite",
day: "Tuesday/Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 11
},{
name: "HS Government",
description: "This year-long course will examine the history and philosophy of political theory as it has evolved worldwide, with a weekly spotlight on current events and their political contexts and relevance. In the second semester, the focus of the course will be the United States government and its structure and function. For its duration, the aim of the class will be to foster and encourage critical thought and logical processes. This course is designed to qualify for a high school social studies credit.",
grades: "9,10,12,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11
},{
name: "HS Lit 1",
description: "This course develops student competency in English usage and mechanics, written communication, and classical and contemporary literature. Basic grammar skills are practiced in student writings. Students use analytical and critical thinking skills while examining the various literary forms.",
grades: "9,10",
suggested_grade: "9,10",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11
},{
name: "HS Lit 2",
description: "A survey of a diverse swath of (predominately 20th and early 21st Century) literature. We will be considering each piece of writing on at least a few levels, looking at not only more surface-level questions of plot and tone, but also considering aesthetic and artistic design, symbolism, and context. Readings will mostly be provided by the instructor. The class will take more of a ""writing workshop"" form, with instructor-guided peer editing and class discussion figuring prominently.",
grades: "10,11,12",
suggested_grade: "10-12",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11
},{
name: "HS Spanish 1",
description: "Designed to introduce beginner students to the Spanish language. A communicative approach is taken to gain skills in speaking, comprehension, reading and writing. This course is designed to qualify for a high school language credit and meets on Tuesdays AND Thursdays.",
grades:  "8,9,10,11,12",
suggested_grade: "8-12",
day: "Tuesday/Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11
},{
name: "HS US History, Section 1",
description: "This course provides a one-year survey of American history from the American Revolution to the present.  Using the textbook and primary documents and current events, students learn about the various political, social, religious, and economic developments that have shaped and continue to shape the United States.  Essay writing and critical thinking are emphasized as integral ways of understanding how the past relates to the present and future. ",
grades: "8,9,10",
suggested_grade: "8-10",
day: "Tuesday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11
},{
name: "HS US History, Section 2",
description: "This course provides a one-year survey of American history from the American Revolution to the present.  Using the textbook and primary documents and current events, students learn about the various political, social, religious, and economic developments that have shaped and continue to shape the United States.  Essay writing and critical thinking are emphasized as integral ways of understanding how the past relates to the present and future. ",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11
},{
name: "HS Writer's Toolkit",
description: "Designed for the high school writer who needs to shore up their writing mechanics. The course will focus on grammar and expanding a student's vocabulary through study of Greek and Latin roots and will cover the topics tested in the verbal sections of the ACT and SAT college entrance exams.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11
},{
name: "Intro to Spanish",
description: "Designed to give the novice second-language student a taste of the Spanish speaking world, while making the language accessible and comprehensible. This class meets on Tuesday AND Thursday.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Tuesday/Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 11,
class_maximum: 15
},{
name: "Magic & Monsters",
description: "Designed around a year-long theme of Magic & Monsters, this class will examine various ways in which human beings engage with their fears and discomforts, their hopes and dreams on the written page. Appropriate for students who are comfortable writing three paragraph essays and connecting themes in literature; will focus heavily on a wide range of writing and exploration into various types of texts. Texts from 2019-2020 included: The Brothers Grimm Annotated Anthology, The Riverman by Aaron Starmer, A Monster Calls by Patrick Ness, The Picture of Dorian Gray by Oscar Wilde, Tales Of Beedle the Bard by J.K. Rowling, and Children of Blood & Bone by Tomi Adeyemi.",
grades: "7,8,9",
suggested_grade: "8",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "MS Math",
description: "Will cover the topics normally covered in a middle school 7th grade math course. This course is designed to prepare students for Pre-Algebra and meets on Tuesdays AND Thursdays.",
grades:  "5,6,7",
suggested_grade: "7; placement test is required",
day: "Tuesday/Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Phy Sci",
description: "Students will learn about mechanics, heat, electricity, atomic structure, astronomy and more. Students should be enrolled in at least Pre-Algebra math concurrently. (Math does not have to be taken at WEB.)",
grades: 8,
suggested_grade: "8",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 16
},{
name: "Pre Algebra",
description: "Will cover the topics normally covered in a middle school prealgebra course. This course is designed to prepare students for Algebra 1 and meets on Tuesdays AND Thursdays.",
grades:  "7,8",
suggested_grade: "8; MS Math is pre-requisite and placement test is required for new students",
day: "Tuesday/Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Public Speaking",
description: "This course is aimed to reduce students’ anxiety in presentations and other public speaking occasions. Topics include learning how to interpret and display accurate body language, eye contact, breath control, and tone of voice. This is a performative class. Students will be asked to prepare multiple presentations over the course of the year to present to class. A focus will be placed on how to transfer their new skills to other class presentations, school interviews, and cultivate poise for all areas of life.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 11,
class_maximum: 15
},{
name: "Reading for Writing",
description: "Students will read a variety of works by #OwnVoices authors, which will serve as models for a variety of writing projects such as personal narratives, imaginative narratives, informational material, and opinion pieces. Designed for students who can write a strong sentence and are familiar with the basic conventions of written English (capitalization, punctuation, indentation, etc.). The reading list for this course is still being finalized; previous titles have included Esperanza Rising, One Crazy Summer, Inside Out and Back Again and I Am Malala (Young Reader's Edition).",
grades: "5,6",
suggested_grade: "5",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "STEAM",
description: "STEAM class will be a hands-on experience. Each week students will be presented with materials and design challenges that incorporate different aspects of Science, Technology, Engineering, Arts, and Mathematics. Students will be encouraged to think critically and creatively about how to design and improve their projects.",
grades: "5,6,7",
suggested_grade: "5-7",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "Studio 1",
description: "Studio 1 is designed to encourage and support students in their unique creative journey. An emphasis will be placed on traditional studio development with a strong focus on realistic drawing skills, observational drawing practice, 3 dimensional shading, multi-point perspectives, and figure drawing. Recommended for previous WEB art students OR 7th and 8th grade students.",
grades: "6,7,8",
suggested_grade: "6-8",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 14
},{
name: "Studio 2",
description: "Studio 2 provides a space for artistically motivated, driven and experienced students who are ready to undertake new creative challenges in an independent work environment. During this studio course students will focus on defining their unique artistic voice while learning how to provide, process and utilize constructive feedback in a supportive and nurturing community of fellow artists. Studio 2 prerequisite requirement: Completion of WEB Studio 1 with teacher recommendation OR personal portfolio submission plus interview with the instructor demonstrating a variety of creative material familiarity and comfort.",
grades: "7,8",
suggested_grade: "7-8; WEB Studio I is pre-requisite or submission of portfolio for new students",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 12
},{
name: "Studio Fund",
description: "An introduction to the creative tools, materials and vocabulary that provide a foundation in the fine arts. Learn the basics of visual communication by developing observational drawing skills while also receiving instruction in color theory techniques, watercolor and acrylic painting, oil pastels, printmaking, ceramic sculpture, and so much more. This course concludes with the assembly of a student portfolio. WEB Studio Fundamentals is recommended for 5th and 6th grade students and serves as a prerequisite fulfillment for WEB Art Studio 1.",
grades: "5,6",
suggested_grade: "5-6",
day: "Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Tuesday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Tuesday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 0,
class_maximum: 10
},{
name: "Middle School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 0,
class_maximum: 10
},{
name: "The Outsider",
description: "Everyone has felt like an outsider at some point, but we must all choose how we deal with the experience of being outside of the norm. In this class we will read stories that look at the different ways people feel separate from the world and how they deal with it. Do they escape? Do they find ways to return to the world with their new self? Do they conform? This class will use mainly reflective writing in order to strengthen students’ ability to shape and express ideas about the novels. This class is recommended for 7th and 8th grade students who have not taken Reading for Writing and Award Winning Literature at WEB.",
grades: "7,8",
suggested_grade: "7-8",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 11,
class_maximum: 15
},{
name: "TN History",
description: "Students will examine the history of Tennessee, including the cultural, geographic, economic, and political influences upon that history. Content will include the foundation of the state of Tennessee, the origins, impact, and aftermath of the Civil War, the rise of a manufacturing economy and the Civil Rights Movement.",
grades: "7,8",
suggested_grade: "7-8",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "US Geography",
description: "This course will examine the historical and spatial growth and development of the United States. Students will learn about state boundaries, state capitals and landforms.",
grades: "5,6,7,8",
suggested_grade: "5-8",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Walk the Land",
description: "Walk the Land is a class that encourages play and self-discovery, combining outdoor education with literature and art. Students will spend time outdoors learning about the trees and plants around them, gardening, and also creatively building poems, crafts, and ideas in tandem with nature.",
grades: "5,6,7,8,9",
suggested_grade: "5-9",
day: "Tuesday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 11,
class_maximum: 15
},{
name: "Walk the Land",
description: "Walk the Land is a class that encourages play and self-discovery, combining outdoor education with literature and art. Students will spend time outdoors learning about the trees and plants around them, gardening, and also creatively building poems, crafts, and ideas in tandem with nature.",
grades: "5,6,7,8,9",
suggested_grade: "5-9",
day: "Tuesday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11,
class_maximum: 15
},{
name: "Writer's Workshop",
description: "In writers workshop, students will bring in writing assignments from other classes and work together with the instructor and classmates to correct, refine, and expound upon what they’ve already done. Through these exercises, students will be reintroduced to grammar concepts as well as concepts of good writing and rhetoric. The goal will be to take their papers from good to great. This course will be loosely based on the IEW writing course but will not be as intense or require nearly as much outside work.",
grades: "6,7,8",
suggested_grade: "6-8",
day: "Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 11,
class_maximum: 15
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Thursday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Tuesday",
start_time: "13:00",
end_time: "14:30",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Thursday",
start_time: "8:45",
end_time: "9:55",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Thursday",
start_time: "9:55",
end_time: "11:00",
class_minimum: 0,
class_maximum: 10
},{
name: "High School Study Hall",
description: "WEB study hall provides a quiet, but not silent, environment for students to work on their homework and/or play board games or puzzles with other study hall students. Adult supervision is provided. Students may not take more than one study hall per day.",
grades: "9,10,11,12",
suggested_grade: "9-12",
day: "Thursday",
start_time: "11:30",
end_time: "13:00",
class_minimum: 0,
class_maximum: 10
}])

p "Created #{Course.count} courses"

# --- END COURSE SEEDS ---

# ---  BEGIN PRODUCT SEEDS ---

Product.destroy_all

products = Product.create([
  {
  name: "Advanced Science Survey class fee",
  unit_price: 35,
  product_type: "fee"
  },{
  name: "Algebra class fee",
  unit_price: 50,
  product_type: "fee"
  },{
  name: "American Lit class fee",
  unit_price: 10,
  product_type: "fee"
  },{
  name: "HS Spanish 1 class fee",
  unit_price: 0,
  product_type: "fee"
  },{
  name: "Award Winning Lit class fee",
  unit_price: 10,
  product_type: "fee"
  },{
  name: "Bio class fee",
  unit_price: 35,
  product_type: "fee"
  },{
  name: "Chem class fee",
  unit_price: 60,
  product_type: "fee"
  },{
  name: "Creative Writing/Yearbook class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "Eye Witness to History class fee",
  unit_price: 30,
  product_type: "fee"
  },{
  name: "Gen Sci class fee",
  unit_price: 45,
  product_type: "fee"
  },{
  name: "Genre Book Club class fee",
  unit_price: 0,
  product_type: "fee"
  },{
  name: "Grammar/Spelling class fee",
  unit_price: 5,
  product_type: "fee"
  },{
  name: "How to Learn a Language class fee",
  unit_price: 30,
  product_type: "fee"
  },{
  name: "HS 2D Art & Design class fee",
  unit_price: 0,
  product_type: "fee"
  },{
  name: "HS Bio class fee",
  unit_price: 50,
  product_type: "fee"
  },{
  name: "HS Chem class fee",
  unit_price: 50,
  product_type: "fee"
  },{
  name: "HS French class fee",
  unit_price: 30,
  product_type: "fee"
  },{
  name: "HS Geometry class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "HS Government class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "HS Lit 1 class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "HS Lit 2 class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "HS US History class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "HS US History class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "HS Writer's Toolkit class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "Intro to Spanish class fee",
  unit_price: 30,
  product_type: "fee"
  },{
  name: "Magic & Monsters class fee",
  unit_price: 20,
  product_type: "fee"
  },{
  name: "MS Math class fee",
  unit_price: 30,
  product_type: "fee"
  },{
  name: "Phy Sci class fee",
  unit_price: 100,
  product_type: "fee"
  },{
  name: "Pre Algebra class fee",
  unit_price: 40,
  product_type: "fee"
  },{
  name: "Public Speaking class fee",
  unit_price: 0,
  product_type: "fee"
  },{
  name: "Reading for Writing class fee",
  unit_price: 25,
  product_type: "fee"
  },{
  name: "STEAM class fee",
  unit_price: 50,
  product_type: "fee"
  },{
  name: "Studio 1 class fee",
  unit_price: 75,
  product_type: "fee"
  },{
  name: "Studio 2 class fee",
  unit_price: 75,
  product_type: "fee"
  },{
  name: "Studio Fund class fee",
  unit_price: 60,
  product_type: "fee"
  },{
  name: "Study Hall class fee",
  unit_price: 0,
  product_type: "fee"
  },{
  name: "The Outsider class fee",
  unit_price: 10,
  product_type: "fee"
  },{
  name: "TN History class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "US Geography class fee",
  unit_price: 15,
  product_type: "fee"
  },{
  name: "Walk the Land class fee",
  unit_price: 35,
  product_type: "fee"
  },{
  name: "Walk the Land class fee",
  unit_price: 35,
  product_type: "fee"
  },{
  name: "Writer's Workshop class fee",
  unit_price: 15,
  product_type: "fee"
  }])

  p "Created #{Product.count} products"

  # --- END PRODUCT SEEDS ---
