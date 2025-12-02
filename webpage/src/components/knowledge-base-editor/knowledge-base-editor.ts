import {Component, inject, OnInit} from '@angular/core';
import {FormsModule} from '@angular/forms';
import {KBEService} from '../../service/kbe/kbeservice';
import {KBE} from '../../models/kbe.model';

@Component({
  selector: 'app-knowledge-base-editor',
  imports: [FormsModule],
  templateUrl: './knowledge-base-editor.html',
  styleUrl: './knowledge-base-editor.css',
})
export class KnowledgeBaseEditor implements OnInit {

  protected textControl = "";


  protected kbe!: KBE;

  protected preview: string = "";


  private kbeService: KBEService = inject(KBEService);

  constructor() {

  }


  ngOnInit(): void {
    this.kbeService.get().then((res) => {
      this.kbe = res;
      this.textControl = res.text;
      this.preview = res.text;
    });
  }

  protected save() {
    this.kbe.text = this.textControl;
    this.kbeService.update(this.kbe).then(res => this.preview = res.text);
  }
}
