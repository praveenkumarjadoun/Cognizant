import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Subscription } from 'rxjs';
import { CourseService } from '../../services/course';

@Component({
  selector: 'app-course-summary-widget',
  imports: [CommonModule],
  templateUrl: './course-summary-widget.html',
  styleUrl: './course-summary-widget.css',
})
export class CourseSummaryWidget implements OnInit, OnDestroy {
  coursesCount = 0;
  private sub?: Subscription;

  constructor(private courseService: CourseService) {}

  ngOnInit(): void {
    this.loadCount();
  }

  loadCount(): void {
    if (this.sub) {
      this.sub.unsubscribe();
    }
    this.sub = this.courseService.getCourses().subscribe({
      next: (courses) => {
        this.coursesCount = courses.length;
      },
      error: (err) => console.error('Failed to load courses count:', err)
    });
  }

  addMockCourse(): void {
    const nextId = Math.floor(Math.random() * 1000) + 10;
    this.courseService.createCourse({
      name: `New Mock Course ${nextId}`,
      code: `CS30${nextId}`,
      credits: 3,
      gradeStatus: 'pending'
    }).subscribe({
      next: () => {
        this.loadCount();
      },
      error: (err) => console.error('Failed to create mock course:', err)
    });
  }

  ngOnDestroy(): void {
    if (this.sub) {
      this.sub.unsubscribe();
    }
  }
}
