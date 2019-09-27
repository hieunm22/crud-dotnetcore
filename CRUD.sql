use FPTIS
go
IF OBJECT_ID('dbo.Billionaire', 'U') IS NOT NULL
drop table Billionaire
go
IF OBJECT_ID('dbo.Nation', 'U') IS NOT NULL
drop table Nation
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.getall')
                    --AND type IN ( N'P', N'PC',N'X',N'RF')
		) 
	drop procedure getall
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.paging')
		) 
	drop procedure paging
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.removebyid')
		) 
	drop procedure getbyid
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.removebyid')
		) 
	drop procedure removebyid
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.removeall')
		) 
	drop procedure removeall
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.updatebyid')
		) 
	drop procedure updatebyid
go
IF EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'dbo.insertnew')
		) 
	drop procedure insertnew
go
create table Nation
(
	ID bigint primary key identity(1,1),
	Name nvarchar(200),
	Area decimal,
)
go
create table Billionaire
(
	ID bigint primary key identity(1,1),
	Name nvarchar(200),
	BornYear int,
	Company nvarchar(200),
	NationID bigint references Nation(id),
	Asset decimal
)
go
create procedure getall
as
begin
	select * from Billionaire
end
go
create procedure paging
@pagenumber int,
@pagesize int
as
begin
	select top (@pagesize) * from
	(
		select top (@pagesize * @pagenumber) * from Billionaire
		except
		select top (@pagesize * (@pagenumber - 1)) * from Billionaire
	) paging
end
go
create procedure getbyid
@id bigint
as
begin
	select * from Billionaire where id=@id
end
go
create procedure removebyid
@id bigint
as
begin
	delete from Billionaire where id=@id
end
go
create procedure removeall
as
begin
	delete from Billionaire
end
go
create procedure updatebyid
@Name nvarchar(200),
@BornYear int,
@Company nvarchar(200),
@NationID bigint,
@Asset int,
@ID bigint
as
begin
	Update Billionaire SET Name=@Name, BornYear=@BornYear, Company=@Company, NationID=@NationID, Asset=@Asset Where Id=@ID
end
go
create procedure insertnew
@Name nvarchar(200),
@BornYear int,
@Company nvarchar(200),
@NationID bigint,
@Asset int
as
begin
	insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (@Name, @BornYear, @Company, @NationID, @Asset)
end
go
insert into Nation(Name, Area) values ('Afghanistan', 647500)
insert into Nation(Name, Area) values ('Albania', 28748)
insert into Nation(Name, Area) values ('Algeria', 2381740)
insert into Nation(Name, Area) values ('American Samoa', 199)
insert into Nation(Name, Area) values ('Andorra', 468)
insert into Nation(Name, Area) values ('Angola', 1246700)
insert into Nation(Name, Area) values ('Anguilla', 102)
insert into Nation(Name, Area) values ('Antigua & Barbuda', 443)
insert into Nation(Name, Area) values ('Argentina', 2766890)
insert into Nation(Name, Area) values ('Armenia', 29800)
insert into Nation(Name, Area) values ('Aruba', 193)
insert into Nation(Name, Area) values ('Australia', 7686850)
insert into Nation(Name, Area) values ('Austria', 83870)
insert into Nation(Name, Area) values ('Azerbaijan', 86600)
insert into Nation(Name, Area) values ('Bahamas, The', 13940)
insert into Nation(Name, Area) values ('Bahrain', 665)
insert into Nation(Name, Area) values ('Bangladesh', 144000)
insert into Nation(Name, Area) values ('Barbados', 431)
insert into Nation(Name, Area) values ('Belarus', 207600)
insert into Nation(Name, Area) values ('Belgium', 30528)
insert into Nation(Name, Area) values ('Belize', 22966)
insert into Nation(Name, Area) values ('Benin', 112620)
insert into Nation(Name, Area) values ('Bermuda', 53)
insert into Nation(Name, Area) values ('Bhutan', 47000)
insert into Nation(Name, Area) values ('Bolivia', 1098580)
insert into Nation(Name, Area) values ('Bosnia & Herzegovina', 51129)
insert into Nation(Name, Area) values ('Botswana', 600370)
insert into Nation(Name, Area) values ('Brazil', 8511965)
insert into Nation(Name, Area) values ('British Virgin Is.', 153)
insert into Nation(Name, Area) values ('Brunei', 5770)
insert into Nation(Name, Area) values ('Bulgaria', 110910)
insert into Nation(Name, Area) values ('Burkina Faso', 274200)
insert into Nation(Name, Area) values ('Burma', 678500)
insert into Nation(Name, Area) values ('Burundi', 27830)
insert into Nation(Name, Area) values ('Cambodia', 181040)
insert into Nation(Name, Area) values ('Cameroon', 475440)
insert into Nation(Name, Area) values ('Canada', 9984670)
insert into Nation(Name, Area) values ('Cape Verde', 4033)
insert into Nation(Name, Area) values ('Cayman Islands', 262)
insert into Nation(Name, Area) values ('Central African Rep.', 622984)
insert into Nation(Name, Area) values ('Chad', 1284000)
insert into Nation(Name, Area) values ('Chile', 756950)
insert into Nation(Name, Area) values ('China', 9596960)
insert into Nation(Name, Area) values ('Colombia', 1138910)
insert into Nation(Name, Area) values ('Comoros', 2170)
insert into Nation(Name, Area) values ('Congo, Dem. Rep.', 2345410)
insert into Nation(Name, Area) values ('Congo, Repub. of the', 342000)
insert into Nation(Name, Area) values ('Cook Islands', 240)
insert into Nation(Name, Area) values ('Costa Rica', 51100)
insert into Nation(Name, Area) values ('Cote d''Ivoire', 322460)
insert into Nation(Name, Area) values ('Croatia', 56542)
insert into Nation(Name, Area) values ('Cuba', 110860)
insert into Nation(Name, Area) values ('Cyprus', 9250)
insert into Nation(Name, Area) values ('Czech Republic', 78866)
insert into Nation(Name, Area) values ('Denmark', 43094)
insert into Nation(Name, Area) values ('Djibouti', 23000)
insert into Nation(Name, Area) values ('Dominica', 754)
insert into Nation(Name, Area) values ('Dominican Republic', 48730)
insert into Nation(Name, Area) values ('East Timor', 15007)
insert into Nation(Name, Area) values ('Ecuador', 283560)
insert into Nation(Name, Area) values ('Egypt', 1001450)
insert into Nation(Name, Area) values ('El Salvador', 21040)
insert into Nation(Name, Area) values ('Equatorial Guinea', 28051)
insert into Nation(Name, Area) values ('Eritrea', 121320)
insert into Nation(Name, Area) values ('Estonia', 45226)
insert into Nation(Name, Area) values ('Ethiopia', 1127127)
insert into Nation(Name, Area) values ('Faroe Islands', 1399)
insert into Nation(Name, Area) values ('Fiji', 18270)
insert into Nation(Name, Area) values ('Finland', 338145)
insert into Nation(Name, Area) values ('France', 547030)
insert into Nation(Name, Area) values ('French Guiana', 91000)
insert into Nation(Name, Area) values ('French Polynesia', 4167)
insert into Nation(Name, Area) values ('Gabon', 267667)
insert into Nation(Name, Area) values ('Gambia, The', 11300)
insert into Nation(Name, Area) values ('Gaza Strip', 360)
insert into Nation(Name, Area) values ('Georgia', 69700)
insert into Nation(Name, Area) values ('Germany', 357021)
insert into Nation(Name, Area) values ('Ghana', 239460)
insert into Nation(Name, Area) values ('Gibraltar', 7)
insert into Nation(Name, Area) values ('Greece', 131940)
insert into Nation(Name, Area) values ('Greenland', 2166086)
insert into Nation(Name, Area) values ('Grenada', 344)
insert into Nation(Name, Area) values ('Guadeloupe', 1780)
insert into Nation(Name, Area) values ('Guam', 541)
insert into Nation(Name, Area) values ('Guatemala', 108890)
insert into Nation(Name, Area) values ('Guernsey', 78)
insert into Nation(Name, Area) values ('Guinea', 245857)
insert into Nation(Name, Area) values ('Guinea-Bissau', 36120)
insert into Nation(Name, Area) values ('Guyana', 214970)
insert into Nation(Name, Area) values ('Haiti', 27750)
insert into Nation(Name, Area) values ('Honduras', 112090)
insert into Nation(Name, Area) values ('Hong Kong', 1092)
insert into Nation(Name, Area) values ('Hungary', 93030)
insert into Nation(Name, Area) values ('Iceland', 103000)
insert into Nation(Name, Area) values ('India', 3287590)
insert into Nation(Name, Area) values ('Indonesia', 1919440)
insert into Nation(Name, Area) values ('Iran', 1648000)
insert into Nation(Name, Area) values ('Iraq', 437072)
insert into Nation(Name, Area) values ('Ireland', 70280)
insert into Nation(Name, Area) values ('Isle of Man', 572)
insert into Nation(Name, Area) values ('Israel', 20770)
insert into Nation(Name, Area) values ('Italy', 301230)
insert into Nation(Name, Area) values ('Jamaica', 10991)
insert into Nation(Name, Area) values ('Japan', 377835)
insert into Nation(Name, Area) values ('Jersey', 116)
insert into Nation(Name, Area) values ('Jordan', 92300)
insert into Nation(Name, Area) values ('Kazakhstan', 2717300)
insert into Nation(Name, Area) values ('Kenya', 582650)
insert into Nation(Name, Area) values ('Kiribati', 811)
insert into Nation(Name, Area) values ('Korea, North', 120540)
insert into Nation(Name, Area) values ('Korea, South', 98480)
insert into Nation(Name, Area) values ('Kuwait', 17820)
insert into Nation(Name, Area) values ('Kyrgyzstan', 198500)
insert into Nation(Name, Area) values ('Laos', 236800)
insert into Nation(Name, Area) values ('Latvia', 64589)
insert into Nation(Name, Area) values ('Lebanon', 10400)
insert into Nation(Name, Area) values ('Lesotho', 30355)
insert into Nation(Name, Area) values ('Liberia', 111370)
insert into Nation(Name, Area) values ('Libya', 1759540)
insert into Nation(Name, Area) values ('Liechtenstein', 160)
insert into Nation(Name, Area) values ('Lithuania', 65200)
insert into Nation(Name, Area) values ('Luxembourg', 2586)
insert into Nation(Name, Area) values ('Macau', 28)
insert into Nation(Name, Area) values ('Macedonia', 25333)
insert into Nation(Name, Area) values ('Madagascar', 587040)
insert into Nation(Name, Area) values ('Malawi', 118480)
insert into Nation(Name, Area) values ('Malaysia', 329750)
insert into Nation(Name, Area) values ('Maldives', 300)
insert into Nation(Name, Area) values ('Mali', 1240000)
insert into Nation(Name, Area) values ('Malta', 316)
insert into Nation(Name, Area) values ('Marshall Islands', 11854)
insert into Nation(Name, Area) values ('Martinique', 1100)
insert into Nation(Name, Area) values ('Mauritania', 1030700)
insert into Nation(Name, Area) values ('Mauritius', 2040)
insert into Nation(Name, Area) values ('Mayotte', 374)
insert into Nation(Name, Area) values ('Mexico', 1972550)
insert into Nation(Name, Area) values ('Micronesia, Fed. St.', 702)
insert into Nation(Name, Area) values ('Moldova', 33843)
insert into Nation(Name, Area) values ('Monaco', 2)
insert into Nation(Name, Area) values ('Mongolia', 1564116)
insert into Nation(Name, Area) values ('Montserrat', 102)
insert into Nation(Name, Area) values ('Morocco', 446550)
insert into Nation(Name, Area) values ('Mozambique', 801590)
insert into Nation(Name, Area) values ('Namibia', 825418)
insert into Nation(Name, Area) values ('Nauru', 21)
insert into Nation(Name, Area) values ('Nepal', 147181)
insert into Nation(Name, Area) values ('Netherlands', 41526)
insert into Nation(Name, Area) values ('Netherlands Antilles', 960)
insert into Nation(Name, Area) values ('New Caledonia', 19060)
insert into Nation(Name, Area) values ('New Zealand', 268680)
insert into Nation(Name, Area) values ('Nicaragua', 129494)
insert into Nation(Name, Area) values ('Niger', 1267000)
insert into Nation(Name, Area) values ('Nigeria', 923768)
insert into Nation(Name, Area) values ('N. Mariana Islands', 477)
insert into Nation(Name, Area) values ('Norway', 323802)
insert into Nation(Name, Area) values ('Oman', 212460)
insert into Nation(Name, Area) values ('Pakistan', 803940)
insert into Nation(Name, Area) values ('Palau', 458)
insert into Nation(Name, Area) values ('Panama', 78200)
insert into Nation(Name, Area) values ('Papua New Guinea', 462840)
insert into Nation(Name, Area) values ('Paraguay', 406750)
insert into Nation(Name, Area) values ('Peru', 1285220)
insert into Nation(Name, Area) values ('Philippines', 300000)
insert into Nation(Name, Area) values ('Poland', 312685)
insert into Nation(Name, Area) values ('Portugal', 92391)
insert into Nation(Name, Area) values ('Puerto Rico', 13790)
insert into Nation(Name, Area) values ('Qatar', 11437)
insert into Nation(Name, Area) values ('Reunion', 2517)
insert into Nation(Name, Area) values ('Romania', 237500)
insert into Nation(Name, Area) values ('Russia', 17075200)
insert into Nation(Name, Area) values ('Rwanda', 26338)
insert into Nation(Name, Area) values ('Saint Helena', 413)
insert into Nation(Name, Area) values ('Saint Kitts & Nevis', 261)
insert into Nation(Name, Area) values ('Saint Lucia', 616)
insert into Nation(Name, Area) values ('St Pierre & Miquelon', 242)
insert into Nation(Name, Area) values ('Saint Vincent and the Grenadines', 389)
insert into Nation(Name, Area) values ('Samoa', 2944)
insert into Nation(Name, Area) values ('San Marino', 61)
insert into Nation(Name, Area) values ('Sao Tome & Principe', 1001)
insert into Nation(Name, Area) values ('Saudi Arabia', 1960582)
insert into Nation(Name, Area) values ('Senegal', 196190)
insert into Nation(Name, Area) values ('Serbia', 88361)
insert into Nation(Name, Area) values ('Seychelles', 455)
insert into Nation(Name, Area) values ('Sierra Leone', 71740)
insert into Nation(Name, Area) values ('Singapore', 693)
insert into Nation(Name, Area) values ('Slovakia', 48845)
insert into Nation(Name, Area) values ('Slovenia', 20273)
insert into Nation(Name, Area) values ('Solomon Islands', 28450)
insert into Nation(Name, Area) values ('Somalia', 637657)
insert into Nation(Name, Area) values ('South Africa', 1219912)
insert into Nation(Name, Area) values ('Spain', 504782)
insert into Nation(Name, Area) values ('Sri Lanka', 65610)
insert into Nation(Name, Area) values ('Sudan', 2505810)
insert into Nation(Name, Area) values ('Suriname', 163270)
insert into Nation(Name, Area) values ('Swaziland', 17363)
insert into Nation(Name, Area) values ('Sweden', 449964)
insert into Nation(Name, Area) values ('Switzerland', 41290)
insert into Nation(Name, Area) values ('Syria', 185180)
insert into Nation(Name, Area) values ('Taiwan', 35980)
insert into Nation(Name, Area) values ('Tajikistan', 143100)
insert into Nation(Name, Area) values ('Tanzania', 945087)
insert into Nation(Name, Area) values ('Thailand', 514000)
insert into Nation(Name, Area) values ('Togo', 56785)
insert into Nation(Name, Area) values ('Tonga', 748)
insert into Nation(Name, Area) values ('Trinidad & Tobago', 5128)
insert into Nation(Name, Area) values ('Tunisia', 163610)
insert into Nation(Name, Area) values ('Turkey', 780580)
insert into Nation(Name, Area) values ('Turkmenistan', 488100)
insert into Nation(Name, Area) values ('Turks & Caicos Is', 430)
insert into Nation(Name, Area) values ('Tuvalu', 26)
insert into Nation(Name, Area) values ('Uganda', 236040)
insert into Nation(Name, Area) values ('Ukraine', 603700)
insert into Nation(Name, Area) values ('United Arab Emirates', 82880)
insert into Nation(Name, Area) values ('United Kingdom', 244820)
insert into Nation(Name, Area) values ('United States', 9631420)
insert into Nation(Name, Area) values ('Uruguay', 176220)
insert into Nation(Name, Area) values ('Uzbekistan', 447400)
insert into Nation(Name, Area) values ('Vanuatu', 12200)
insert into Nation(Name, Area) values ('Venezuela', 912050)
insert into Nation(Name, Area) values ('Vietnam', 329560)
insert into Nation(Name, Area) values ('Virgin Islands', 1910)
insert into Nation(Name, Area) values ('Wallis and Futuna', 274)
insert into Nation(Name, Area) values ('West Bank', 5860)
insert into Nation(Name, Area) values ('Western Sahara', 266000)
insert into Nation(Name, Area) values ('Yemen', 527970)
insert into Nation(Name, Area) values ('Zambia', 752614)
insert into Nation(Name, Area) values ('Zimbabwe', 390580)
go
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values ('Jeff Bezos', 1964, 'Amazon', 215, 140)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values ('Mark Zuckenberg', 1984, 'Facebook', 215, 63)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values ('Bill Gates', 1955, 'Microsoft', 215, 101)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'Phạm Nhật Vượng', 1968, 'VinGroup', 220, 8)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values ('Jack Ma', 1964, 'Alibaba', 43, 36)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values ('Sergery Brinn', 1973, 'Alphabet', 170, 48)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values ('Larry Page', 1973, 'Alphabet', 215, 49)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'Donald John Trump', 1946, '', 215, 18)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'Nguyễn Thị Phương Thảo', 1970, 'VietJet Air', 220, 1)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'Elon Reeve Musk', 1971, 'Tesla Motors', 215, 18)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'Steve Blamer', 1956, 'Microsoft', 215, 49)
insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'Roman Abramovich', 1966, 'Chelsea', 170, 13)
go
--select * from Nation
go
select * from Billionaire