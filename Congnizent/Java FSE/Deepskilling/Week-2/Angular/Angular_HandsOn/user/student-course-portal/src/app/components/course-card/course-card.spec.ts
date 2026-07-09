import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { SimpleChange, SimpleChanges } from '@angular/core';
import { provideMockStore, MockStore } from '@ngrx/store/testing';
import { CourseCard } from './course-card';
import { Course } from '../../models/course.model';

describe('CourseCard', () => {
  let component: CourseCard;
  let fixture: ComponentFixture<CourseCard>;
  let store: MockStore;

  const mockCourse: Course = {
    id: 1,
    name: 'Data Structures',
    code: 'CS101',
    credits: 4,
    gradeStatus: 'passed'
  };

  const initialState = {
    enrollment: {
      enrolledCourseIds: []
    },
    course: {
      courses: [mockCourse]
    }
  };

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CourseCard],
      providers: [
        provideMockStore({ initialState })
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(CourseCard);
    component = fixture.componentInstance;
    store = TestBed.inject(MockStore);
    component.course = mockCourse;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render @Input course name inside h3 tag', () => {
    component.course = { 
      id: 1, 
      name: 'Data Structures', 
      code: 'CS101', 
      credits: 4, 
      gradeStatus: 'passed' 
    };
    fixture.detectChanges();
    const h3Text = fixture.debugElement.query(By.css('h3')).nativeElement.textContent;
    expect(h3Text).toContain('Data Structures');
  });

  it('should emit @Output enrollRequested event when Enroll is clicked', () => {
    spyOn(component.enrollRequested, 'emit');
    
    const enrollBtn = fixture.debugElement.query(By.css('.btn-primary'));
    enrollBtn.nativeElement.click();
    fixture.detectChanges();
    
    expect(component.enrollRequested.emit).toHaveBeenCalledWith(1);
  });

  it('should log console message on ngOnChanges execution', () => {
    spyOn(console, 'log');
    
    const changes: SimpleChanges = {
      course: new SimpleChange(null, mockCourse, true)
    };
    component.ngOnChanges(changes);
    
    expect(console.log).toHaveBeenCalled();
  });
});
