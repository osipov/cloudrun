terraform {
  required_version = ">= 1.9.0"

  required_providers {
    google = "~> 5.0.0"
  }
}

provider "google" {
  project = "187696739585"
}

resource "google_project_service" "run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = true
}

resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-service"
  location = "us-east1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
        image = "us-east1-docker.pkg.dev/webcontent/cfai/vapi:v7"
        liveness_probe {
            http_get {
                path = "/ready"
            }
        }
        env {
            name = "HOST"
            value = "0.0.0.0"
        }
        env {
            name = "TZ"
            value = "America/New_York"
        }        
        env {
            name = "GOOGLE_SHEET_API_CREDENTIALS_JSON"
            value = file("gsheets_credentials.json")
	    }
        env {
            name = "GOOGLE_SHEET_API_SHEET_ID"
            value = "1riG4SsaYbVewv7_2Or1HmgoZ7fTwHX7ObXpWOKgdgZQ"
        }
        env {
            name = "GOOGLE_CALENDAR_API_CREDENTIALS_JSON"
            value = file("gcal_credentials.json")
	    }
        env {
            name = "GOOGLE_CALENDAR_API_CALENDAR_ID"
            value = "74c90240636a0753c7cf86ad9bb89e2e1d062107e4061f748c76f56cb1ebef21@group.calendar.google.com"
        }
        env {
            name = "DEFAULT_INCREMENT_MINUTES"
            value = "15"
        }      
        env {
            name = "DEFAULT_BOOKING_DURATION_MINUTES"
            value = "15"
        }        
        env {
            name = "DEFAULT_OPENING_TIME"
            value = "8am"
        }        
        env {
            name = "DEFAULT_CLOSING_TIME"
            value = "5pm"
        }        
        env {
            name = "DEFAULT_WEEK_START_WEEKDAY"
            value = "Monday"
        }        
        env {
            name = "DEFAULT_WEEK_END_WEEKDAY"
            value = "Friday"
        }
        env {
            name = "DEFAULT_SAME_DAY_LEAD_TIME_HOURS"
            value = "4"
        }        
        env {
            name = "DEFAULT_SAME_DAY_LEAD_TIME_MINUTES"
            value = "0"
        }        
    }
  }

  traffic {
    percent         = 100
    type            = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  depends_on = [google_project_service.run_api]
}

resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_v2_service.default.name
  location = google_cloud_run_v2_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
