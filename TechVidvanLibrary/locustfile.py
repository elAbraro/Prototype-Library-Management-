from locust import HttpUser, TaskSet, task

class StudentTaskSet(TaskSet):
    @task
    def add_student(self):
        self.client.post("/addstudent/", {
            "sname": "Test Student",
            "studentid": "ST12345"
        })

    @task
    def view_students(self):
        self.client.get("/viewstudents/")

class WebsiteUser(HttpUser):
    tasks = [StudentTaskSet]
    min_wait = 1000
    max_wait = 2000