import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting, HttpTestingController } from '@angular/common/http/testing';
import { CourseService } from './course';
import { Course } from '../models/course.model';

describe('CourseService', () => {
  let service: CourseService;
  let httpMock: HttpTestingController;

  const mockCourses: Course[] = [
    { id: 1, name: 'Web Dev', code: 'CS101', credits: 4, gradeStatus: 'passed' },
    { id: 2, name: 'Advanced Java', code: 'CS102', credits: 3, gradeStatus: 'pending' }
  ];

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        CourseService,
        provideHttpClient(),
        provideHttpClientTesting()
      ]
    });
    service = TestBed.inject(CourseService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should retrieve courses via GET requests (getCourses)', () => {
    service.getCourses().subscribe((courses) => {
      expect(courses.length).toBe(2);
      expect(courses).toEqual(mockCourses);
    });

    const req = httpMock.expectOne('http://localhost:3000/courses');
    expect(req.request.method).toBe('GET');
    req.flush(mockCourses);
  });

  it('should handle error 500 in getCourses gracefully with retry policy', () => {
    service.getCourses().subscribe({
      next: () => fail('Should have failed with 500 error'),
      error: (err) => {
        expect(err.message).toBe('Failed to load courses. Please try again.');
      }
    });

    // Because of retry(2), 1 initial + 2 retries = 3 requests are expected
    for (let i = 0; i < 3; i++) {
      const req = httpMock.expectOne('http://localhost:3000/courses');
      expect(req.request.method).toBe('GET');
      req.flush('Error loading courses', { status: 500, statusText: 'Internal Server Error' });
    }
  });
});
