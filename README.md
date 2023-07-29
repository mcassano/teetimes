# teetimes

0. Migrate
```
bin/rails db:migrate
```

1. Add a Course:
```
bin/rails console
> course = Course.new(name:"Family Sports Golf", address:"Near Mike")
> course.save
```

2. Start the server: bin/rails server

3. Browser: http://localhost/courses

4. Click the course you just added and it will scan Denver Golf for any early tee times for 7 days from now.
