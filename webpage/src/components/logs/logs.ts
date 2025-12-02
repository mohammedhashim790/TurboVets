import {Component} from '@angular/core';
import {NgClass, NgForOf} from '@angular/common';

@Component({
  selector: 'app-logs', imports: [NgForOf, NgClass], templateUrl: './logs.html', styleUrl: './logs.css',
})
export class Logs {
  protected logs: any[] = [];

}
