import { Component } from '@angular/core';
import {FormsModule} from '@angular/forms';

@Component({
  selector: 'app-knowledge-base-editor',
  imports: [
    FormsModule
  ],
  templateUrl: './knowledge-base-editor.html',
  styleUrl: './knowledge-base-editor.css',
})
export class KnowledgeBaseEditor {
  protected content: any;
  protected previewHtml: any;

  protected save() {

  }
}
