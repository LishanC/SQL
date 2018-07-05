drop table asgXML_books;

create table asgXML_books(
  id    int primary key
, book_xml xmltype)
;

insert into asgXML_books values (1, 
'<book>
<bk_id>101</bk_id>
<bk_title>The Political Genius of Abraham Lincoln</bk_title>
<bk_subject>History</bk_subject>
<bk_price>13.96</bk_price>
<bk_authors>
<author>Goodwin</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (2, 
'<book>
<bk_id>102</bk_id>
<bk_title>Goblin Market and Other Poems</bk_title>
<bk_subject>poem</bk_subject>
<bk_price></bk_price>
<bk_authors>
<author>Dodgson</author>
<author>Martin</author>
<author>Carroll</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (3, 
'<book>
<bk_id>103</bk_id>
<bk_title>In the Company of Crows and Ravens</bk_title>
<bk_subject>Science</bk_subject>
<bk_price>18.95</bk_price>
<bk_authors>
<author>Rossetti</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (4, 
'<book>
<bk_id>104</bk_id>
<bk_title>Lichens of North America</bk_title>
<bk_subject>Science</bk_subject>
<bk_price>135.00</bk_price>
<bk_authors>
<author>Brodo</author>
<author>Sharnoff</author>
<author>William</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (5, 
'<book>
<bk_id>105</bk_id>
<bk_title>A Field Guide to Trees of the Northeast</bk_title>
<bk_subject>Science</bk_subject>
<bk_price>25.95</bk_price>
<bk_authors>
<author>Miller</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (6, 
'<book>
<bk_id>106</bk_id>
<bk_title>Windows Forms 2.0 Programming</bk_title>
<bk_subject>Net</bk_subject>
<bk_price>74.99</bk_price>
<bk_authors>
<author>Sells</author>
<author>Weinhardt</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (7, 
'<book>
<bk_id>107</bk_id>
<bk_title>Visual Basic 2008 Recipes</bk_title>
<bk_subject>Net</bk_subject>
<bk_price>79.99</bk_price>
<bk_authors>
<author>Herman</author>
<author>Jones</author>
<author>MacDonald</author>
<author>Rajan</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (8, 
'<book>
<bk_id>108</bk_id>
<bk_title>SQL Server 2005 A Beginner Guide</bk_title>
<bk_subject>Database</bk_subject>
<bk_price>39.99</bk_price>
<bk_authors>
<author>Petkovic</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (9, 
'<book>
<bk_id>109</bk_id>
<bk_title>Visual Studio Tools for Office</bk_title>
<bk_subject>NET</bk_subject>
<bk_price>54.99</bk_price>
<bk_authors>
<author>Carter</author>
<author>Lippert</author>
</bk_authors>
</book>'
);

insert into asgXML_books values (10, 
'<book>
<bk_id>110</bk_id>
<bk_title>Comparative SQL</bk_title>
<bk_subject>Database</bk_subject>
<bk_price>99.99</bk_price>
<bk_authors>
<author>Incognito</author>
</bk_authors>
</book>'
);

select *
from asgXML_books;