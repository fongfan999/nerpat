unless Major.any?
  Major.create [ {:name => 'He thong thong tin' },
                  {:name => 'Khoa hoc may tinh'},
                  {:name => 'Cong nghe pham mem'},
                  {:name => 'Ky thuat va cong nghe thong tin'},
                  {:name => 'Ky thuat may tinh'}
                ]
end
unless School.any?
  School.create [ 
                {:name => 'UIT' }
                ]
end