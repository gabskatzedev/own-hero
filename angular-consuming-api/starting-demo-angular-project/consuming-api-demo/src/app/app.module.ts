import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { LandingPageComponent } from './landing-page/landing-page.component';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { FirstViewComponent } from './first-view/first-view.component';

@NgModule({
  declarations: [
    AppComponent, LandingPageComponent, FirstViewComponent
  ],
  imports: [
    BrowserModule, HttpClientModule, FormsModule,
    RouterModule.forRoot([
      /* ORDER OF THE PATHS MATTER, the wildcard should be at the bottom */
      {path: 'welcome', component: LandingPageComponent},
      {path: '', component: LandingPageComponent},
      {path: 'first-view', component: FirstViewComponent},
      {path: '**', redirectTo: 'welcome', pathMatch: 'full'}
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
