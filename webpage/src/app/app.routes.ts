import {Routes} from '@angular/router';
import {TicketViewer} from '../components/ticket-viewer/ticket-viewer';
import {Logs} from '../components/logs/logs';
import {KnowledgeBaseEditor} from '../components/knowledge-base-editor/knowledge-base-editor';


export const routes: Routes = [{
  path: '', redirectTo: 'ticket', pathMatch: 'full',
}, {
  path: 'ticket', component: TicketViewer
}, /// [loadChildren] is used to lazy load modules.
  {
    path: 'logs', component: Logs,
  }, {
    path: 'kbe', component: KnowledgeBaseEditor,
  }


];
