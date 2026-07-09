import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NotificationService } from '../../services/notification';

@Component({
  selector: 'app-notification',
  imports: [CommonModule],
  templateUrl: './notification.html',
  styleUrl: './notification.css',
  /*
   * HIERARCHICAL DEPENDENCY INJECTION:
   * 
   * Providing `NotificationService` inside the `@Component` decorator's `providers` array
   * creates a new, separate instance of `NotificationService` scoped specifically to this
   * component instance. 
   * 
   * Unlike root-provided singletons, if multiple instances of `<app-notification>` are rendered,
   * each will have its own independent service instance. When this component is destroyed,
   * the scoped service instance is also garbage collected, preventing memory leaks.
   */
  providers: [NotificationService]
})
export class Notification implements OnInit {
  constructor(public notificationService: NotificationService) {}

  ngOnInit(): void {
    this.notificationService.addNotification('System: Ready to receive alerts.');
  }

  addMessage(inputEl: HTMLInputElement): void {
    const val = inputEl.value.trim();
    if (val) {
      this.notificationService.addNotification(val);
      inputEl.value = '';
    }
  }
}
