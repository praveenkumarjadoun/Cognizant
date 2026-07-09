import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Subscription, combineLatest } from 'rxjs';
import { CourseService } from '../../services/course';
import { EnrollmentService } from '../../services/enrollment';
import { CourseSummaryWidget } from '../../components/course-summary-widget/course-summary-widget';

@Component({
  selector: 'app-home',
  imports: [FormsModule, CourseSummaryWidget],
  templateUrl: './home.html',
  styleUrl: './home.css',
})
export class Home implements OnInit, OnDestroy {
  portalName = 'Student Course Portal';
  isPortalActive = true;
  message = '';
  searchTerm = '';
  studentGpa = 3.8;

  coursesAvailableCount = 0;
  coursesEnrolledCount = 0;
  private sub?: Subscription;

  constructor(
    private courseService: CourseService,
    private enrollmentService: EnrollmentService
  ) {}

  ngOnInit(): void {
    console.log('HomeComponent initialised — courses loaded');
    this.loadStats();
  }

  loadStats(): void {
    // Combine both course list and enrolled courses to get dynamic counts
    this.sub = combineLatest([
      this.courseService.getCourses(),
      this.enrollmentService.getEnrolledCourses()
    ]).subscribe({
      next: ([courses, enrolled]) => {
        this.coursesAvailableCount = courses.length;
        this.coursesEnrolledCount = enrolled.length;
      },
      error: (err) => console.error('Failed to load home dashboard stats:', err)
    });
  }

  ngOnDestroy(): void {
    console.log('HomeComponent destroyed');
    if (this.sub) {
      this.sub.unsubscribe();
    }
  }

  onEnrollClick(): void {
    this.message = 'Enrollment opened!';
  }
}
