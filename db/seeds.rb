unless Major.any?
  Major.create! [ {:name => 'He thong thong tin' },
                  {:name => 'Khoa hoc may tinh'},
                  {:name => 'Cong nghe pham mem'},
                  {:name => 'Ky thuat va cong nghe thong tin'},
                  {:name => 'Ky thuat may tinh'}
                ]
end

unless School.any?
  School.create! [ {:name => 'Đại học Công nghệ Thông tin' } ]
end

unless Skill.any?
  Skill.create! [ 
    {name: "Android", logo: "http://imgur.com/u31r4kI.png"},
    {name: "AngularJS", logo: "http://imgur.com/co2VQRO.png"},
    {name: "C", logo: "http://imgur.com/OKl9EhA.png"},
    {name: "C++", logo: "http://imgur.com/GlSMRfU.png"},
    {name: "C#", logo: "http://imgur.com/7R0Ix4P.png"},
    {name: "CSS", logo: "http://imgur.com/l9d2R1h.png"},
    {name: "Django", logo: "http://imgur.com/v1I5uKg.png"},
    {name: "Elixir", logo: "http://imgur.com/I8f73kD.png"},
    {name: "Github", logo: "http://imgur.com/akDSPyS.png"},
    {name: "Go", logo: "http://imgur.com/VTtQkS4.png"},
    {name: "HTML", logo: "http://imgur.com/vXSKfaM.png"},
    {name: "iOS", logo: "http://imgur.com/gQ4G9i0.png"},
    {name: "Java", logo: "http://imgur.com/Ig9Egkw.png"},
    {name: "Javascript", logo: "http://imgur.com/B7V0O9y.png"},
    {name: "Laravel", logo: "http://imgur.com/XXjtUWS.png"},
    {name: "MySQL", logo: "http://imgur.com/CechQoF.png"},
    {name: "NodeJS", logo: "http://imgur.com/zOeskrk.png"},
    {name: "PHP", logo: "http://imgur.com/eTYInmf.png"},
    {name: "PostgreSQL", logo: "http://imgur.com/mJdcEJd.png"},
    {name: "Python", logo: "http://imgur.com/3u6JzuK.png"},
    {name: "React", logo: "http://imgur.com/8d4EEzn.png"},
    {name: "Ruby on Rails", logo: "http://imgur.com/Ux2NGdb.png"},
    {name: "Ruby", logo: "http://imgur.com/gmsGv34.png"},
    {name: "Rust", logo: "http://imgur.com/6s7x4ea.png"}
  ]
end
