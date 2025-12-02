import {
  ChangeDetectorRef,
  Component,
  ElementRef,
  inject,
  OnDestroy,
  OnInit,
  ViewChild,
  ViewContainerRef
} from '@angular/core';
import {DatePipe, NgClass} from '@angular/common';
import {Log, LogLevel} from '../../models/log';
import {LogService} from '../../service/log/log-service';
import {Subscription} from 'rxjs';

@Component({
  selector: 'app-logs', imports: [NgClass, DatePipe], templateUrl: './logs.html', styleUrl: './logs.css',
})
export class Logs implements OnInit, OnDestroy {

  @ViewChild('logElement') logElement!: ElementRef;
  protected logs: Log[] = [];

  private logService: LogService = inject(LogService);
  private logSubscriber: Subscription | undefined;

  constructor(private changeDetectorRef: ChangeDetectorRef) {

  }

  ngOnInit(): void {
    this.logService.list().then(logs => {
      this.logs = logs;
      this.changeDetectorRef.detectChanges();
    });
    this.logSubscriber = this.logService.openStream().subscribe(log => {
      if (log) this.logs.push(log)
      this.changeDetectorRef.detectChanges();
      this.autoScroll();
    })
  }

  private autoScroll() {
    if (this.logSubscriber) {
      const element = this.logElement.nativeElement;
      element.scrollTop = element.scrollHeight;
    }
  }

  ngOnDestroy() {
    this.logService.closeStream();
    this.logSubscriber?.unsubscribe();
  }

  protected readonly LogLevel = LogLevel;
}
