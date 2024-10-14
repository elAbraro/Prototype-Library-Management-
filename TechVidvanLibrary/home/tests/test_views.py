from django.test import TestCase, Client
from django.urls import reverse
from django.contrib.auth.models import User
from home.models import AddStudent

class TestViews(TestCase):
    def setUp(self):
        self.client = Client()
        self.addstudent_url = reverse('addstudent')
        self.viewstudents_url = reverse('viewstudents')
        self.user = User.objects.create_user(username='testuser')
        self.user.set_password('testpassword')
        self.user.save()
        self.client.login(username='testuser', password='testpassword')
        session = self.client.session
        session['is_logged'] = True
        session.save()

    def test_addstudent_view(self):
        response = self.client.get(self.addstudent_url)
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'addstudent.html')

    def test_viewstudents_view(self):
        AddStudent.objects.create(user=self.user, sname="Mr Invincible", studentid="123456")
        response = self.client.get(self.viewstudents_url)
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'viewstudents.html')
