FactoryGirl.define do
  factory :calendar_api_discovery_doc, class: GoogleApiDiscoveryDoc do
    api 'calendar'
    version 'v3'
    
    # Retrieved from https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest
    doc_json <<-eos
{
 "kind": "discovery#restDescription",
 "etag": "\"IhsO6I1JrT_5w9XRpjXK0MUWOF8/KdsWBqbBOAO-TohB2NqKznsSpWE\"",
 "discoveryVersion": "v1",
 "id": "calendar:v3",
 "name": "calendar",
 "version": "v3",
 "revision": "20130805",
 "title": "Calendar API",
 "description": "Lets you manipulate events and other calendar data.",
 "ownerDomain": "google.com",
 "ownerName": "Google",
 "icons": {
  "x16": "http://www.google.com/images/icons/product/calendar-16.png",
  "x32": "http://www.google.com/images/icons/product/calendar-32.png"
 },
 "documentationLink": "https://developers.google.com/google-apps/calendar/firstapp",
 "protocol": "rest",
 "baseUrl": "https://www.googleapis.com/calendar/v3/",
 "basePath": "/calendar/v3/",
 "rootUrl": "https://www.googleapis.com/",
 "servicePath": "calendar/v3/",
 "batchPath": "batch",
 "parameters": {
  "alt": {
   "type": "string",
   "description": "Data format for the response.",
   "default": "json",
   "enum": [
    "json"
   ],
   "enumDescriptions": [
    "Responses with Content-Type of application/json"
   ],
   "location": "query"
  },
  "fields": {
   "type": "string",
   "description": "Selector specifying which fields to include in a partial response.",
   "location": "query"
  },
  "key": {
   "type": "string",
   "description": "API key. Your API key identifies your project and provides you with API access, quota, and reports. Required unless you provide an OAuth 2.0 token.",
   "location": "query"
  },
  "oauth_token": {
   "type": "string",
   "description": "OAuth 2.0 token for the current user.",
   "location": "query"
  },
  "prettyPrint": {
   "type": "boolean",
   "description": "Returns response with indentations and line breaks.",
   "default": "true",
   "location": "query"
  },
  "quotaUser": {
   "type": "string",
   "description": "Available to use for quota purposes for server-side applications. Can be any arbitrary string assigned to a user, but should not exceed 40 characters. Overrides userIp if both are provided.",
   "location": "query"
  },
  "userIp": {
   "type": "string",
   "description": "IP address of the site where the request originates. Use this if you want to enforce per-user limits.",
   "location": "query"
  }
 },
 "auth": {
  "oauth2": {
   "scopes": {
    "https://www.googleapis.com/auth/calendar": {
     "description": "Manage your calendars"
    },
    "https://www.googleapis.com/auth/calendar.readonly": {
     "description": "View your calendars"
    }
   }
  }
 },
 "schemas": {
  "Acl": {
   "id": "Acl",
   "type": "object",
   "properties": {
    "etag": {
     "type": "string",
     "description": "ETag of the collection."
    },
    "items": {
     "type": "array",
     "description": "List of rules on the access control list.",
     "items": {
      "$ref": "AclRule"
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the collection (\"calendar#acl\").",
     "default": "calendar#acl"
    },
    "nextPageToken": {
     "type": "string",
     "description": "Token used to access the next page of this result. Omitted if no further results are available."
    }
   }
  },
  "AclRule": {
   "id": "AclRule",
   "type": "object",
   "properties": {
    "etag": {
     "type": "string",
     "description": "ETag of the resource."
    },
    "id": {
     "type": "string",
     "description": "Identifier of the ACL rule."
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#aclRule\").",
     "default": "calendar#aclRule"
    },
    "role": {
     "type": "string",
     "description": "The role assigned to the scope. Possible values are:  \n- \"none\" - Provides no access. \n- \"freeBusyReader\" - Provides read access to free/busy information. \n- \"reader\" - Provides read access to the calendar. Private events will appear to users with reader access, but event details will be hidden. \n- \"writer\" - Provides read and write access to the calendar. Private events will appear to users with writer access, and event details will be visible. \n- \"owner\" - Provides ownership of the calendar. This role has all of the permissions of the writer role with the additional ability to see and manipulate ACLs.",
     "annotations": {
      "required": [
       "calendar.acl.insert"
      ]
     }
    },
    "scope": {
     "type": "object",
     "description": "The scope of the rule.",
     "properties": {
      "type": {
       "type": "string",
       "description": "The type of the scope. Possible values are:  \n- \"default\" - The public scope. This is the default value. \n- \"user\" - Limits the scope to a single user. \n- \"group\" - Limits the scope to a group. \n- \"domain\" - Limits the scope to a domain.  Note: The permissions granted to the \"default\", or public, scope apply to any user, authenticated or not.",
       "annotations": {
        "required": [
         "calendar.acl.insert"
        ]
       }
      },
      "value": {
       "type": "string",
       "description": "The email address of a user or group, or the name of a domain, depending on the scope type. Omitted for type \"default\"."
      }
     },
     "annotations": {
      "required": [
       "calendar.acl.insert"
      ]
     }
    }
   }
  },
  "Calendar": {
   "id": "Calendar",
   "type": "object",
   "properties": {
    "description": {
     "type": "string",
     "description": "Description of the calendar. Optional."
    },
    "etag": {
     "type": "string",
     "description": "ETag of the resource."
    },
    "id": {
     "type": "string",
     "description": "Identifier of the calendar."
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#calendar\").",
     "default": "calendar#calendar"
    },
    "location": {
     "type": "string",
     "description": "Geographic location of the calendar as free-form text. Optional."
    },
    "summary": {
     "type": "string",
     "description": "Title of the calendar.",
     "annotations": {
      "required": [
       "calendar.calendars.insert"
      ]
     }
    },
    "timeZone": {
     "type": "string",
     "description": "The time zone of the calendar. Optional."
    }
   }
  },
  "CalendarList": {
   "id": "CalendarList",
   "type": "object",
   "properties": {
    "etag": {
     "type": "string",
     "description": "ETag of the collection."
    },
    "items": {
     "type": "array",
     "description": "Calendars that are present on the user's calendar list.",
     "items": {
      "$ref": "CalendarListEntry"
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the collection (\"calendar#calendarList\").",
     "default": "calendar#calendarList"
    },
    "nextPageToken": {
     "type": "string",
     "description": "Token used to access the next page of this result."
    }
   }
  },
  "CalendarListEntry": {
   "id": "CalendarListEntry",
   "type": "object",
   "properties": {
    "accessRole": {
     "type": "string",
     "description": "The effective access role that the authenticated user has on the calendar. Read-only. Possible values are:  \n- \"freeBusyReader\" - Provides read access to free/busy information. \n- \"reader\" - Provides read access to the calendar. Private events will appear to users with reader access, but event details will be hidden. \n- \"writer\" - Provides read and write access to the calendar. Private events will appear to users with writer access, and event details will be visible. \n- \"owner\" - Provides ownership of the calendar. This role has all of the permissions of the writer role with the additional ability to see and manipulate ACLs."
    },
    "backgroundColor": {
     "type": "string",
     "description": "The main color of the calendar in the format '#0088aa'. This property supersedes the index-based colorId property. Optional."
    },
    "colorId": {
     "type": "string",
     "description": "The color of the calendar. This is an ID referring to an entry in the \"calendar\" section of the colors definition (see the \"colors\" endpoint). Optional."
    },
    "defaultReminders": {
     "type": "array",
     "description": "The default reminders that the authenticated user has for this calendar.",
     "items": {
      "$ref": "EventReminder"
     }
    },
    "description": {
     "type": "string",
     "description": "Description of the calendar. Optional. Read-only."
    },
    "etag": {
     "type": "string",
     "description": "ETag of the resource."
    },
    "foregroundColor": {
     "type": "string",
     "description": "The foreground color of the calendar in the format '#ffffff'. This property supersedes the index-based colorId property. Optional."
    },
    "hidden": {
     "type": "boolean",
     "description": "Whether the calendar has been hidden from the list. Optional. The default is False.",
     "default": "false"
    },
    "id": {
     "type": "string",
     "description": "Identifier of the calendar.",
     "annotations": {
      "required": [
       "calendar.calendarList.insert"
      ]
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#calendarListEntry\").",
     "default": "calendar#calendarListEntry"
    },
    "location": {
     "type": "string",
     "description": "Geographic location of the calendar as free-form text. Optional. Read-only."
    },
    "primary": {
     "type": "boolean",
     "description": "Whether the calendar is the primary calendar of the authenticated user. Read-only. Optional. The default is False.",
     "default": "false"
    },
    "selected": {
     "type": "boolean",
     "description": "Whether the calendar content shows up in the calendar UI. Optional. The default is False.",
     "default": "false"
    },
    "summary": {
     "type": "string",
     "description": "Title of the calendar. Read-only."
    },
    "summaryOverride": {
     "type": "string",
     "description": "The summary that the authenticated user has set for this calendar. Optional."
    },
    "timeZone": {
     "type": "string",
     "description": "The time zone of the calendar. Optional. Read-only."
    }
   }
  },
  "Channel": {
   "id": "Channel",
   "type": "object",
   "properties": {
    "address": {
     "type": "string",
     "description": "The address where notifications are delivered for this channel."
    },
    "expiration": {
     "type": "string",
     "description": "Date and time of notification channel expiration, expressed as a Unix timestamp, in milliseconds. Optional.",
     "format": "int64"
    },
    "id": {
     "type": "string",
     "description": "A UUID or similar unique string that identifies this channel."
    },
    "kind": {
     "type": "string",
     "description": "Identifies this as a notification channel used to watch for changes to a resource. Value: the fixed string \"api#channel\".",
     "default": "api#channel"
    },
    "params": {
     "type": "object",
     "description": "Additional parameters controlling delivery channel behavior. Optional.",
     "additionalProperties": {
      "type": "string",
      "description": "Declares a new parameter by name."
     }
    },
    "payload": {
     "type": "boolean",
     "description": "A Boolean value to indicate whether payload is wanted. Optional."
    },
    "resourceId": {
     "type": "string",
     "description": "An opaque ID that identifies the resource being watched on this channel. Stable across different API versions."
    },
    "resourceUri": {
     "type": "string",
     "description": "A version-specific identifier for the watched resource."
    },
    "token": {
     "type": "string",
     "description": "An arbitrary string delivered to the target address with each notification delivered over this channel. Optional."
    },
    "type": {
     "type": "string",
     "description": "The type of delivery mechanism used for this channel."
    }
   }
  },
  "ColorDefinition": {
   "id": "ColorDefinition",
   "type": "object",
   "properties": {
    "background": {
     "type": "string",
     "description": "The background color associated with this color definition."
    },
    "foreground": {
     "type": "string",
     "description": "The foreground color that can be used to write on top of a background with 'background' color."
    }
   }
  },
  "Colors": {
   "id": "Colors",
   "type": "object",
   "properties": {
    "calendar": {
     "type": "object",
     "description": "Palette of calendar colors, mapping from the color ID to its definition. An 'calendarListEntry' resource refers to one of these color IDs in its 'color' field. Read-only.",
     "additionalProperties": {
      "$ref": "ColorDefinition",
      "description": "A calendar color defintion."
     }
    },
    "event": {
     "type": "object",
     "description": "Palette of event colors, mapping from the color ID to its definition. An 'event' resource may refer to one of these color IDs in its 'color' field. Read-only.",
     "additionalProperties": {
      "$ref": "ColorDefinition",
      "description": "An event color definition."
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#colors\").",
     "default": "calendar#colors"
    },
    "updated": {
     "type": "string",
     "description": "Last modification time of the color palette (as a RFC 3339 timestamp). Read-only.",
     "format": "date-time"
    }
   }
  },
  "Error": {
   "id": "Error",
   "type": "object",
   "properties": {
    "domain": {
     "type": "string",
     "description": "Domain, or broad category, of the error."
    },
    "reason": {
     "type": "string",
     "description": "Specific reason for the error. Some of the possible values are:  \n- \"groupTooBig\" - The group of users requested is too large for a single query. \n- \"tooManyCalendarsRequested\" - The number of calendars requested is too large for a single query. \n- \"notFound\" - The requested resource was not found. \n- \"internalError\" - The API service has encountered an internal error.  Additional error types may be added in the future, so clients should gracefully handle additional error statuses not included in this list."
    }
   }
  },
  "Event": {
   "id": "Event",
   "type": "object",
   "properties": {
    "anyoneCanAddSelf": {
     "type": "boolean",
     "description": "Whether anyone can invite themselves to the event. Optional. The default is False.",
     "default": "false"
    },
    "attendees": {
     "type": "array",
     "description": "The attendees of the event.",
     "items": {
      "$ref": "EventAttendee"
     }
    },
    "attendeesOmitted": {
     "type": "boolean",
     "description": "Whether attendees may have been omitted from the event's representation. When retrieving an event, this may be due to a restriction specified by the 'maxAttendee' query parameter. When updating an event, this can be used to only update the participant's response. Optional. The default is False.",
     "default": "false"
    },
    "colorId": {
     "type": "string",
     "description": "The color of the event. This is an ID referring to an entry in the \"event\" section of the colors definition (see the \"colors\" endpoint). Optional."
    },
    "created": {
     "type": "string",
     "description": "Creation time of the event (as a RFC 3339 timestamp). Read-only.",
     "format": "date-time"
    },
    "creator": {
     "type": "object",
     "description": "The creator of the event. Read-only.",
     "properties": {
      "displayName": {
       "type": "string",
       "description": "The creator's name, if available."
      },
      "email": {
       "type": "string",
       "description": "The creator's email address, if available."
      },
      "id": {
       "type": "string",
       "description": "The creator's Profile ID, if available."
      },
      "self": {
       "type": "boolean",
       "description": "Whether the creator corresponds to the calendar on which this copy of the event appears. Read-only. The default is False.",
       "default": "false"
      }
     }
    },
    "description": {
     "type": "string",
     "description": "Description of the event. Optional."
    },
    "end": {
     "$ref": "EventDateTime",
     "description": "The (exclusive) end time of the event. For a recurring event, this is the end time of the first instance.",
     "annotations": {
      "required": [
       "calendar.events.import",
       "calendar.events.insert",
       "calendar.events.update"
      ]
     }
    },
    "endTimeUnspecified": {
     "type": "boolean",
     "description": "Whether the end time is actually unspecified. An end time is still provided for compatibility reasons, even if this attribute is set to True. The default is False.",
     "default": "false"
    },
    "etag": {
     "type": "string",
     "description": "ETag of the resource."
    },
    "extendedProperties": {
     "type": "object",
     "description": "Extended properties of the event.",
     "properties": {
      "private": {
       "type": "object",
       "description": "Properties that are private to the copy of the event that appears on this calendar.",
       "additionalProperties": {
        "type": "string",
        "description": "The name of the private property and the corresponding value."
       }
      },
      "shared": {
       "type": "object",
       "description": "Properties that are shared between copies of the event on other attendees' calendars.",
       "additionalProperties": {
        "type": "string",
        "description": "The name of the shared property and the corresponding value."
       }
      }
     }
    },
    "gadget": {
     "type": "object",
     "description": "A gadget that extends this event.",
     "properties": {
      "display": {
       "type": "string",
       "description": "The gadget's display mode. Optional. Possible values are:  \n- \"icon\" - The gadget displays next to the event's title in the calendar view. \n- \"chip\" - The gadget displays when the event is clicked."
      },
      "height": {
       "type": "integer",
       "description": "The gadget's height in pixels. Optional.",
       "format": "int32"
      },
      "iconLink": {
       "type": "string",
       "description": "The gadget's icon URL."
      },
      "link": {
       "type": "string",
       "description": "The gadget's URL."
      },
      "preferences": {
       "type": "object",
       "description": "Preferences.",
       "additionalProperties": {
        "type": "string",
        "description": "The preference name and corresponding value."
       }
      },
      "title": {
       "type": "string",
       "description": "The gadget's title."
      },
      "type": {
       "type": "string",
       "description": "The gadget's type."
      },
      "width": {
       "type": "integer",
       "description": "The gadget's width in pixels. Optional.",
       "format": "int32"
      }
     }
    },
    "guestsCanInviteOthers": {
     "type": "boolean",
     "description": "Whether attendees other than the organizer can invite others to the event. Optional. The default is True.",
     "default": "true"
    },
    "guestsCanModify": {
     "type": "boolean",
     "description": "Whether attendees other than the organizer can modify the event. Optional. The default is False.",
     "default": "false"
    },
    "guestsCanSeeOtherGuests": {
     "type": "boolean",
     "description": "Whether attendees other than the organizer can see who the event's attendees are. Optional. The default is True.",
     "default": "true"
    },
    "hangoutLink": {
     "type": "string",
     "description": "An absolute link to the Google+ hangout associated with this event. Read-only."
    },
    "htmlLink": {
     "type": "string",
     "description": "An absolute link to this event in the Google Calendar Web UI. Read-only."
    },
    "iCalUID": {
     "type": "string",
     "description": "Event ID in the iCalendar format.",
     "annotations": {
      "required": [
       "calendar.events.import"
      ]
     }
    },
    "id": {
     "type": "string",
     "description": "Identifier of the event."
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#event\").",
     "default": "calendar#event"
    },
    "location": {
     "type": "string",
     "description": "Geographic location of the event as free-form text. Optional."
    },
    "locked": {
     "type": "boolean",
     "description": "Whether this is a locked event copy where no changes can be made to the main event fields \"summary\", \"description\", \"location\", \"start\", \"end\" or \"recurrence\". The default is False. Read-Only.",
     "default": "false"
    },
    "organizer": {
     "type": "object",
     "description": "The organizer of the event. If the organizer is also an attendee, this is indicated with a separate entry in 'attendees' with the 'organizer' field set to True. To change the organizer, use the \"move\" operation. Read-only, except when importing an event.",
     "properties": {
      "displayName": {
       "type": "string",
       "description": "The organizer's name, if available."
      },
      "email": {
       "type": "string",
       "description": "The organizer's email address, if available."
      },
      "id": {
       "type": "string",
       "description": "The organizer's Profile ID, if available."
      },
      "self": {
       "type": "boolean",
       "description": "Whether the organizer corresponds to the calendar on which this copy of the event appears. Read-only. The default is False.",
       "default": "false"
      }
     }
    },
    "originalStartTime": {
     "$ref": "EventDateTime",
     "description": "For an instance of a recurring event, this is the time at which this event would start according to the recurrence data in the recurring event identified by recurringEventId. Immutable."
    },
    "privateCopy": {
     "type": "boolean",
     "description": "Whether this is a private event copy where changes are not shared with other copies on other calendars. Optional. Immutable. The default is False.",
     "default": "false"
    },
    "recurrence": {
     "type": "array",
     "description": "List of RRULE, EXRULE, RDATE and EXDATE lines for a recurring event. This field is omitted for single events or instances of recurring events.",
     "items": {
      "type": "string"
     }
    },
    "recurringEventId": {
     "type": "string",
     "description": "For an instance of a recurring event, this is the event ID of the recurring event itself. Immutable."
    },
    "reminders": {
     "type": "object",
     "description": "Information about the event's reminders for the authenticated user.",
     "properties": {
      "overrides": {
       "type": "array",
       "description": "If the event doesn't use the default reminders, this lists the reminders specific to the event, or, if not set, indicates that no reminders are set for this event.",
       "items": {
        "$ref": "EventReminder"
       }
      },
      "useDefault": {
       "type": "boolean",
       "description": "Whether the default reminders of the calendar apply to the event."
      }
     }
    },
    "sequence": {
     "type": "integer",
     "description": "Sequence number as per iCalendar.",
     "format": "int32"
    },
    "source": {
     "type": "object",
     "description": "Source of an event from which it was created; for example a web page, an email message or any document identifiable by an URL using HTTP/HTTPS protocol. Accessible only by the creator of the event.",
     "properties": {
      "title": {
       "type": "string",
       "description": "Title of the source; for example a title of a web page or an email subject."
      },
      "url": {
       "type": "string",
       "description": "URL of the source pointing to a resource. URL's protocol must be HTTP or HTTPS."
      }
     }
    },
    "start": {
     "$ref": "EventDateTime",
     "description": "The (inclusive) start time of the event. For a recurring event, this is the start time of the first instance.",
     "annotations": {
      "required": [
       "calendar.events.import",
       "calendar.events.insert",
       "calendar.events.update"
      ]
     }
    },
    "status": {
     "type": "string",
     "description": "Status of the event. Optional. Possible values are:  \n- \"confirmed\" - The event is confirmed. This is the default status. \n- \"tentative\" - The event is tentatively confirmed. \n- \"cancelled\" - The event is cancelled."
    },
    "summary": {
     "type": "string",
     "description": "Title of the event."
    },
    "transparency": {
     "type": "string",
     "description": "Whether the event blocks time on the calendar. Optional. Possible values are:  \n- \"opaque\" - The event blocks time on the calendar. This is the default value. \n- \"transparent\" - The event does not block time on the calendar.",
     "default": "opaque"
    },
    "updated": {
     "type": "string",
     "description": "Last modification time of the event (as a RFC 3339 timestamp). Read-only.",
     "format": "date-time"
    },
    "visibility": {
     "type": "string",
     "description": "Visibility of the event. Optional. Possible values are:  \n- \"default\" - Uses the default visibility for events on the calendar. This is the default value. \n- \"public\" - The event is public and event details are visible to all readers of the calendar. \n- \"private\" - The event is private and only event attendees may view event details. \n- \"confidential\" - The event is private. This value is provided for compatibility reasons.",
     "default": "default"
    }
   }
  },
  "EventAttendee": {
   "id": "EventAttendee",
   "type": "object",
   "properties": {
    "additionalGuests": {
     "type": "integer",
     "description": "Number of additional guests. Optional. The default is 0.",
     "format": "int32"
    },
    "comment": {
     "type": "string",
     "description": "The attendee's response comment. Optional."
    },
    "displayName": {
     "type": "string",
     "description": "The attendee's name, if available. Optional."
    },
    "email": {
     "type": "string",
     "description": "The attendee's email address, if available. This field must be present when adding an attendee.",
     "annotations": {
      "required": [
       "calendar.events.import",
       "calendar.events.insert",
       "calendar.events.update"
      ]
     }
    },
    "id": {
     "type": "string",
     "description": "The attendee's Profile ID, if available."
    },
    "optional": {
     "type": "boolean",
     "description": "Whether this is an optional attendee. Optional. The default is False."
    },
    "organizer": {
     "type": "boolean",
     "description": "Whether the attendee is the organizer of the event. Read-only. The default is False."
    },
    "resource": {
     "type": "boolean",
     "description": "Whether the attendee is a resource. Read-only. The default is False."
    },
    "responseStatus": {
     "type": "string",
     "description": "The attendee's response status. Possible values are:  \n- \"needsAction\" - The attendee has not responded to the invitation. \n- \"declined\" - The attendee has declined the invitation. \n- \"tentative\" - The attendee has tentatively accepted the invitation. \n- \"accepted\" - The attendee has accepted the invitation."
    },
    "self": {
     "type": "boolean",
     "description": "Whether this entry represents the calendar on which this copy of the event appears. Read-only. The default is False."
    }
   }
  },
  "EventDateTime": {
   "id": "EventDateTime",
   "type": "object",
   "properties": {
    "date": {
     "type": "string",
     "description": "The date, in the format \"yyyy-mm-dd\", if this is an all-day event.",
     "format": "date"
    },
    "dateTime": {
     "type": "string",
     "description": "The time, as a combined date-time value (formatted according to RFC 3339). A time zone offset is required unless a time zone is explicitly specified in 'timeZone'.",
     "format": "date-time"
    },
    "timeZone": {
     "type": "string",
     "description": "The name of the time zone in which the time is specified (e.g. \"Europe/Zurich\"). Optional. The default is the time zone of the calendar."
    }
   }
  },
  "EventReminder": {
   "id": "EventReminder",
   "type": "object",
   "properties": {
    "method": {
     "type": "string",
     "description": "The method used by this reminder. Possible values are:  \n- \"email\" - Reminders are sent via email. \n- \"sms\" - Reminders are sent via SMS. \n- \"popup\" - Reminders are sent via a UI popup.",
     "annotations": {
      "required": [
       "calendar.calendarList.insert",
       "calendar.calendarList.update",
       "calendar.events.import",
       "calendar.events.insert",
       "calendar.events.update"
      ]
     }
    },
    "minutes": {
     "type": "integer",
     "description": "Number of minutes before the start of the event when the reminder should trigger.",
     "format": "int32",
     "annotations": {
      "required": [
       "calendar.calendarList.insert",
       "calendar.calendarList.update",
       "calendar.events.import",
       "calendar.events.insert",
       "calendar.events.update"
      ]
     }
    }
   }
  },
  "Events": {
   "id": "Events",
   "type": "object",
   "properties": {
    "accessRole": {
     "type": "string",
     "description": "The user's access role for this calendar. Read-only. Possible values are:  \n- \"none\" - The user has no access. \n- \"freeBusyReader\" - The user has read access to free/busy information. \n- \"reader\" - The user has read access to the calendar. Private events will appear to users with reader access, but event details will be hidden. \n- \"writer\" - The user has read and write access to the calendar. Private events will appear to users with writer access, and event details will be visible. \n- \"owner\" - The user has ownership of the calendar. This role has all of the permissions of the writer role with the additional ability to see and manipulate ACLs."
    },
    "defaultReminders": {
     "type": "array",
     "description": "The default reminders on the calendar for the authenticated user. These reminders apply to all events on this calendar that do not explicitly override them (i.e. do not have 'reminders.useDefault' set to 'true').",
     "items": {
      "$ref": "EventReminder"
     }
    },
    "description": {
     "type": "string",
     "description": "Description of the calendar. Read-only."
    },
    "etag": {
     "type": "string",
     "description": "ETag of the collection."
    },
    "items": {
     "type": "array",
     "description": "List of events on the calendar.",
     "items": {
      "$ref": "Event"
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the collection (\"calendar#events\").",
     "default": "calendar#events"
    },
    "nextPageToken": {
     "type": "string",
     "description": "Token used to access the next page of this result. Omitted if no further results are available."
    },
    "summary": {
     "type": "string",
     "description": "Title of the calendar. Read-only."
    },
    "timeZone": {
     "type": "string",
     "description": "The time zone of the calendar. Read-only."
    },
    "updated": {
     "type": "string",
     "description": "Last modification time of the calendar (as a RFC 3339 timestamp). Read-only.",
     "format": "date-time"
    }
   }
  },
  "FreeBusyCalendar": {
   "id": "FreeBusyCalendar",
   "type": "object",
   "properties": {
    "busy": {
     "type": "array",
     "description": "List of time ranges during which this calendar should be regarded as busy.",
     "items": {
      "$ref": "TimePeriod"
     }
    },
    "errors": {
     "type": "array",
     "description": "Optional error(s) (if computation for the calendar failed).",
     "items": {
      "$ref": "Error"
     }
    }
   }
  },
  "FreeBusyGroup": {
   "id": "FreeBusyGroup",
   "type": "object",
   "properties": {
    "calendars": {
     "type": "array",
     "description": "List of calendars' identifiers within a group.",
     "items": {
      "type": "string"
     }
    },
    "errors": {
     "type": "array",
     "description": "Optional error(s) (if computation for the group failed).",
     "items": {
      "$ref": "Error"
     }
    }
   }
  },
  "FreeBusyRequest": {
   "id": "FreeBusyRequest",
   "type": "object",
   "properties": {
    "calendarExpansionMax": {
     "type": "integer",
     "description": "Maximal number of calendars for which FreeBusy information is to be provided. Optional.",
     "format": "int32"
    },
    "groupExpansionMax": {
     "type": "integer",
     "description": "Maximal number of calendar identifiers to be provided for a single group. Optional. An error will be returned for a group with more members than this value.",
     "format": "int32"
    },
    "items": {
     "type": "array",
     "description": "List of calendars and/or groups to query.",
     "items": {
      "$ref": "FreeBusyRequestItem"
     }
    },
    "timeMax": {
     "type": "string",
     "description": "The end of the interval for the query.",
     "format": "date-time"
    },
    "timeMin": {
     "type": "string",
     "description": "The start of the interval for the query.",
     "format": "date-time"
    },
    "timeZone": {
     "type": "string",
     "description": "Time zone used in the response. Optional. The default is UTC.",
     "default": "UTC"
    }
   }
  },
  "FreeBusyRequestItem": {
   "id": "FreeBusyRequestItem",
   "type": "object",
   "properties": {
    "id": {
     "type": "string",
     "description": "The identifier of a calendar or a group."
    }
   }
  },
  "FreeBusyResponse": {
   "id": "FreeBusyResponse",
   "type": "object",
   "properties": {
    "calendars": {
     "type": "object",
     "description": "List of free/busy information for calendars.",
     "additionalProperties": {
      "$ref": "FreeBusyCalendar",
      "description": "Free/busy expansions for a single calendar."
     }
    },
    "groups": {
     "type": "object",
     "description": "Expansion of groups.",
     "additionalProperties": {
      "$ref": "FreeBusyGroup",
      "description": "List of calendars that are members of this group."
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#freeBusy\").",
     "default": "calendar#freeBusy"
    },
    "timeMax": {
     "type": "string",
     "description": "The end of the interval.",
     "format": "date-time"
    },
    "timeMin": {
     "type": "string",
     "description": "The start of the interval.",
     "format": "date-time"
    }
   }
  },
  "Setting": {
   "id": "Setting",
   "type": "object",
   "properties": {
    "etag": {
     "type": "string",
     "description": "ETag of the resource."
    },
    "id": {
     "type": "string",
     "description": "Name of the user setting."
    },
    "kind": {
     "type": "string",
     "description": "Type of the resource (\"calendar#setting\").",
     "default": "calendar#setting"
    },
    "value": {
     "type": "string",
     "description": "Value of the user setting. The format of the value depends on the ID of the setting."
    }
   }
  },
  "Settings": {
   "id": "Settings",
   "type": "object",
   "properties": {
    "etag": {
     "type": "string",
     "description": "Etag of the collection."
    },
    "items": {
     "type": "array",
     "description": "List of user settings.",
     "items": {
      "$ref": "Setting"
     }
    },
    "kind": {
     "type": "string",
     "description": "Type of the collection (\"calendar#settings\").",
     "default": "calendar#settings"
    }
   }
  },
  "TimePeriod": {
   "id": "TimePeriod",
   "type": "object",
   "properties": {
    "end": {
     "type": "string",
     "description": "The (exclusive) end of the time period.",
     "format": "date-time"
    },
    "start": {
     "type": "string",
     "description": "The (inclusive) start of the time period.",
     "format": "date-time"
    }
   }
  }
 },
 "resources": {
  "acl": {
   "methods": {
    "delete": {
     "id": "calendar.acl.delete",
     "path": "calendars/{calendarId}/acl/{ruleId}",
     "httpMethod": "DELETE",
     "description": "Deletes an access control rule.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "ruleId": {
       "type": "string",
       "description": "ACL rule identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId",
      "ruleId"
     ],
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "get": {
     "id": "calendar.acl.get",
     "path": "calendars/{calendarId}/acl/{ruleId}",
     "httpMethod": "GET",
     "description": "Returns an access control rule.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "ruleId": {
       "type": "string",
       "description": "ACL rule identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId",
      "ruleId"
     ],
     "response": {
      "$ref": "AclRule"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    },
    "insert": {
     "id": "calendar.acl.insert",
     "path": "calendars/{calendarId}/acl",
     "httpMethod": "POST",
     "description": "Creates an access control rule.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "AclRule"
     },
     "response": {
      "$ref": "AclRule"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "list": {
     "id": "calendar.acl.list",
     "path": "calendars/{calendarId}/acl",
     "httpMethod": "GET",
     "description": "Returns the rules in the access control list for the calendar.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "response": {
      "$ref": "Acl"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "patch": {
     "id": "calendar.acl.patch",
     "path": "calendars/{calendarId}/acl/{ruleId}",
     "httpMethod": "PATCH",
     "description": "Updates an access control rule. This method supports patch semantics.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "ruleId": {
       "type": "string",
       "description": "ACL rule identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId",
      "ruleId"
     ],
     "request": {
      "$ref": "AclRule"
     },
     "response": {
      "$ref": "AclRule"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "update": {
     "id": "calendar.acl.update",
     "path": "calendars/{calendarId}/acl/{ruleId}",
     "httpMethod": "PUT",
     "description": "Updates an access control rule.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "ruleId": {
       "type": "string",
       "description": "ACL rule identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId",
      "ruleId"
     ],
     "request": {
      "$ref": "AclRule"
     },
     "response": {
      "$ref": "AclRule"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    }
   }
  },
  "calendarList": {
   "methods": {
    "delete": {
     "id": "calendar.calendarList.delete",
     "path": "users/me/calendarList/{calendarId}",
     "httpMethod": "DELETE",
     "description": "Deletes an entry on the user's calendar list.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "get": {
     "id": "calendar.calendarList.get",
     "path": "users/me/calendarList/{calendarId}",
     "httpMethod": "GET",
     "description": "Returns an entry on the user's calendar list.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "response": {
      "$ref": "CalendarListEntry"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    },
    "insert": {
     "id": "calendar.calendarList.insert",
     "path": "users/me/calendarList",
     "httpMethod": "POST",
     "description": "Adds an entry to the user's calendar list.",
     "parameters": {
      "colorRgbFormat": {
       "type": "boolean",
       "description": "Whether to use the 'foregroundColor' and 'backgroundColor' fields to write the calendar colors (RGB). If this feature is used, the index-based 'colorId' field will be set to the best matching option automatically. Optional. The default is False.",
       "location": "query"
      }
     },
     "request": {
      "$ref": "CalendarListEntry"
     },
     "response": {
      "$ref": "CalendarListEntry"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "list": {
     "id": "calendar.calendarList.list",
     "path": "users/me/calendarList",
     "httpMethod": "GET",
     "description": "Returns entries on the user's calendar list.",
     "parameters": {
      "maxResults": {
       "type": "integer",
       "description": "Maximum number of entries returned on one result page. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "minAccessRole": {
       "type": "string",
       "description": "The minimum access role for the user in the returned entires. Optional. The default is no restriction.",
       "enum": [
        "freeBusyReader",
        "owner",
        "reader",
        "writer"
       ],
       "enumDescriptions": [
        "The user can read free/busy information.",
        "The user can read and modify events and access control lists.",
        "The user can read events that are not private.",
        "The user can read and modify events."
       ],
       "location": "query"
      },
      "pageToken": {
       "type": "string",
       "description": "Token specifying which result page to return. Optional.",
       "location": "query"
      },
      "showHidden": {
       "type": "boolean",
       "description": "Whether to show hidden entries. Optional. The default is False.",
       "location": "query"
      }
     },
     "response": {
      "$ref": "CalendarList"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    },
    "patch": {
     "id": "calendar.calendarList.patch",
     "path": "users/me/calendarList/{calendarId}",
     "httpMethod": "PATCH",
     "description": "Updates an entry on the user's calendar list. This method supports patch semantics.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "colorRgbFormat": {
       "type": "boolean",
       "description": "Whether to use the 'foregroundColor' and 'backgroundColor' fields to write the calendar colors (RGB). If this feature is used, the index-based 'colorId' field will be set to the best matching option automatically. Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "CalendarListEntry"
     },
     "response": {
      "$ref": "CalendarListEntry"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "update": {
     "id": "calendar.calendarList.update",
     "path": "users/me/calendarList/{calendarId}",
     "httpMethod": "PUT",
     "description": "Updates an entry on the user's calendar list.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "colorRgbFormat": {
       "type": "boolean",
       "description": "Whether to use the 'foregroundColor' and 'backgroundColor' fields to write the calendar colors (RGB). If this feature is used, the index-based 'colorId' field will be set to the best matching option automatically. Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "CalendarListEntry"
     },
     "response": {
      "$ref": "CalendarListEntry"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    }
   }
  },
  "calendars": {
   "methods": {
    "clear": {
     "id": "calendar.calendars.clear",
     "path": "calendars/{calendarId}/clear",
     "httpMethod": "POST",
     "description": "Clears a primary calendar. This operation deletes all data associated with the primary calendar of an account and cannot be undone.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "delete": {
     "id": "calendar.calendars.delete",
     "path": "calendars/{calendarId}",
     "httpMethod": "DELETE",
     "description": "Deletes a secondary calendar.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "get": {
     "id": "calendar.calendars.get",
     "path": "calendars/{calendarId}",
     "httpMethod": "GET",
     "description": "Returns metadata for a calendar.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "response": {
      "$ref": "Calendar"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    },
    "insert": {
     "id": "calendar.calendars.insert",
     "path": "calendars",
     "httpMethod": "POST",
     "description": "Creates a secondary calendar.",
     "request": {
      "$ref": "Calendar"
     },
     "response": {
      "$ref": "Calendar"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "patch": {
     "id": "calendar.calendars.patch",
     "path": "calendars/{calendarId}",
     "httpMethod": "PATCH",
     "description": "Updates metadata for a calendar. This method supports patch semantics.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "Calendar"
     },
     "response": {
      "$ref": "Calendar"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "update": {
     "id": "calendar.calendars.update",
     "path": "calendars/{calendarId}",
     "httpMethod": "PUT",
     "description": "Updates metadata for a calendar.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "Calendar"
     },
     "response": {
      "$ref": "Calendar"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    }
   }
  },
  "channels": {
   "methods": {
    "stop": {
     "id": "calendar.channels.stop",
     "path": "channels/stop",
     "httpMethod": "POST",
     "description": "Stop watching resources through this channel",
     "request": {
      "$ref": "Channel"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    }
   }
  },
  "colors": {
   "methods": {
    "get": {
     "id": "calendar.colors.get",
     "path": "colors",
     "httpMethod": "GET",
     "description": "Returns the color definitions for calendars and events.",
     "response": {
      "$ref": "Colors"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    }
   }
  },
  "events": {
   "methods": {
    "delete": {
     "id": "calendar.events.delete",
     "path": "calendars/{calendarId}/events/{eventId}",
     "httpMethod": "DELETE",
     "description": "Deletes an event.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "eventId": {
       "type": "string",
       "description": "Event identifier.",
       "required": true,
       "location": "path"
      },
      "sendNotifications": {
       "type": "boolean",
       "description": "Whether to send notifications about the deletion of the event. Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "eventId"
     ],
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "get": {
     "id": "calendar.events.get",
     "path": "calendars/{calendarId}/events/{eventId}",
     "httpMethod": "GET",
     "description": "Returns an event.",
     "parameters": {
      "alwaysIncludeEmail": {
       "type": "boolean",
       "description": "Whether to always include a value in the \"email\" field for the organizer, creator and attendees, even if no real email is available (i.e. a generated, non-working value will be provided). The use of this option is discouraged and should only be used by clients which cannot handle the absence of an email address value in the mentioned places. Optional. The default is False.",
       "location": "query"
      },
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "eventId": {
       "type": "string",
       "description": "Event identifier.",
       "required": true,
       "location": "path"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "timeZone": {
       "type": "string",
       "description": "Time zone used in the response. Optional. The default is the time zone of the calendar.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "eventId"
     ],
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    },
    "import": {
     "id": "calendar.events.import",
     "path": "calendars/{calendarId}/events/import",
     "httpMethod": "POST",
     "description": "Imports an event. This operation is used to add a private copy of an existing event to a calendar.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "Event"
     },
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "insert": {
     "id": "calendar.events.insert",
     "path": "calendars/{calendarId}/events",
     "httpMethod": "POST",
     "description": "Creates an event.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "sendNotifications": {
       "type": "boolean",
       "description": "Whether to send notifications about the creation of the new event. Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "Event"
     },
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "instances": {
     "id": "calendar.events.instances",
     "path": "calendars/{calendarId}/events/{eventId}/instances",
     "httpMethod": "GET",
     "description": "Returns instances of the specified recurring event.",
     "parameters": {
      "alwaysIncludeEmail": {
       "type": "boolean",
       "description": "Whether to always include a value in the \"email\" field for the organizer, creator and attendees, even if no real email is available (i.e. a generated, non-working value will be provided). The use of this option is discouraged and should only be used by clients which cannot handle the absence of an email address value in the mentioned places. Optional. The default is False.",
       "location": "query"
      },
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "eventId": {
       "type": "string",
       "description": "Recurring event identifier.",
       "required": true,
       "location": "path"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "maxResults": {
       "type": "integer",
       "description": "Maximum number of events returned on one result page. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "originalStart": {
       "type": "string",
       "description": "The original start time of the instance in the result. Optional.",
       "location": "query"
      },
      "pageToken": {
       "type": "string",
       "description": "Token specifying which result page to return. Optional.",
       "location": "query"
      },
      "showDeleted": {
       "type": "boolean",
       "description": "Whether to include deleted events (with 'status' equals 'cancelled') in the result. Cancelled instances of recurring events will still be included if 'singleEvents' is False. Optional. The default is False.",
       "location": "query"
      },
      "timeMax": {
       "type": "string",
       "description": "Upper bound (exclusive) for an event's start time to filter by. Optional. The default is not to filter by start time.",
       "format": "date-time",
       "location": "query"
      },
      "timeMin": {
       "type": "string",
       "description": "Lower bound (inclusive) for an event's end time to filter by. Optional. The default is not to filter by end time.",
       "format": "date-time",
       "location": "query"
      },
      "timeZone": {
       "type": "string",
       "description": "Time zone used in the response. Optional. The default is the time zone of the calendar.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "eventId"
     ],
     "response": {
      "$ref": "Events"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ],
     "supportsSubscription": true
    },
    "list": {
     "id": "calendar.events.list",
     "path": "calendars/{calendarId}/events",
     "httpMethod": "GET",
     "description": "Returns events on the specified calendar.",
     "parameters": {
      "alwaysIncludeEmail": {
       "type": "boolean",
       "description": "Whether to always include a value in the \"email\" field for the organizer, creator and attendees, even if no real email is available (i.e. a generated, non-working value will be provided). The use of this option is discouraged and should only be used by clients which cannot handle the absence of an email address value in the mentioned places. Optional. The default is False.",
       "location": "query"
      },
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "iCalUID": {
       "type": "string",
       "description": "Specifies iCalendar UID (iCalUID) of events to be included in the response. Optional.",
       "location": "query"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "maxResults": {
       "type": "integer",
       "description": "Maximum number of events returned on one result page. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "orderBy": {
       "type": "string",
       "description": "The order of the events returned in the result. Optional. The default is an unspecified, stable order.",
       "enum": [
        "startTime",
        "updated"
       ],
       "enumDescriptions": [
        "Order by the start date/time (ascending). This is only available when querying single events (i.e. the parameter \"singleEvents\" is True)",
        "Order by last modification time (ascending)."
       ],
       "location": "query"
      },
      "pageToken": {
       "type": "string",
       "description": "Token specifying which result page to return. Optional.",
       "location": "query"
      },
      "q": {
       "type": "string",
       "description": "Free text search terms to find events that match these terms in any field, except for extended properties. Optional.",
       "location": "query"
      },
      "showDeleted": {
       "type": "boolean",
       "description": "Whether to include deleted events (with 'status' equals 'cancelled') in the result. Cancelled instances of recurring events (but not the underlying recurring event) will still be included if 'showDeleted' and 'singleEvents' are both False. If 'showDeleted' and 'singleEvents' are both True, only single instances of deleted events (but not the underlying recurring events) are returned. Optional. The default is False.",
       "location": "query"
      },
      "showHiddenInvitations": {
       "type": "boolean",
       "description": "Whether to include hidden invitations in the result. Optional. The default is False.",
       "location": "query"
      },
      "singleEvents": {
       "type": "boolean",
       "description": "Whether to expand recurring events into instances and only return single one-off events and instances of recurring events, but not the underlying recurring events themselves. Optional. The default is False.",
       "location": "query"
      },
      "timeMax": {
       "type": "string",
       "description": "Upper bound (exclusive) for an event's start time to filter by. Optional. The default is not to filter by start time.",
       "format": "date-time",
       "location": "query"
      },
      "timeMin": {
       "type": "string",
       "description": "Lower bound (inclusive) for an event's end time to filter by. Optional. The default is not to filter by end time.",
       "format": "date-time",
       "location": "query"
      },
      "timeZone": {
       "type": "string",
       "description": "Time zone used in the response. Optional. The default is the time zone of the calendar.",
       "location": "query"
      },
      "updatedMin": {
       "type": "string",
       "description": "Lower bound for an event's last modification time (as a RFC 3339 timestamp) to filter by. Optional. The default is not to filter by last modification time.",
       "format": "date-time",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "response": {
      "$ref": "Events"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ],
     "supportsSubscription": true
    },
    "move": {
     "id": "calendar.events.move",
     "path": "calendars/{calendarId}/events/{eventId}/move",
     "httpMethod": "POST",
     "description": "Moves an event to another calendar, i.e. changes an event's organizer.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier of the source calendar where the event currently is on.",
       "required": true,
       "location": "path"
      },
      "destination": {
       "type": "string",
       "description": "Calendar identifier of the target calendar where the event is to be moved to.",
       "required": true,
       "location": "query"
      },
      "eventId": {
       "type": "string",
       "description": "Event identifier.",
       "required": true,
       "location": "path"
      },
      "sendNotifications": {
       "type": "boolean",
       "description": "Whether to send notifications about the change of the event's organizer. Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "eventId",
      "destination"
     ],
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "patch": {
     "id": "calendar.events.patch",
     "path": "calendars/{calendarId}/events/{eventId}",
     "httpMethod": "PATCH",
     "description": "Updates an event. This method supports patch semantics.",
     "parameters": {
      "alwaysIncludeEmail": {
       "type": "boolean",
       "description": "Whether to always include a value in the \"email\" field for the organizer, creator and attendees, even if no real email is available (i.e. a generated, non-working value will be provided). The use of this option is discouraged and should only be used by clients which cannot handle the absence of an email address value in the mentioned places. Optional. The default is False.",
       "location": "query"
      },
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "eventId": {
       "type": "string",
       "description": "Event identifier.",
       "required": true,
       "location": "path"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "sendNotifications": {
       "type": "boolean",
       "description": "Whether to send notifications about the event update (e.g. attendee's responses, title changes, etc.). Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "eventId"
     ],
     "request": {
      "$ref": "Event"
     },
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "quickAdd": {
     "id": "calendar.events.quickAdd",
     "path": "calendars/{calendarId}/events/quickAdd",
     "httpMethod": "POST",
     "description": "Creates an event based on a simple text string.",
     "parameters": {
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "sendNotifications": {
       "type": "boolean",
       "description": "Whether to send notifications about the creation of the event. Optional. The default is False.",
       "location": "query"
      },
      "text": {
       "type": "string",
       "description": "The text describing the event to be created.",
       "required": true,
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "text"
     ],
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "update": {
     "id": "calendar.events.update",
     "path": "calendars/{calendarId}/events/{eventId}",
     "httpMethod": "PUT",
     "description": "Updates an event.",
     "parameters": {
      "alwaysIncludeEmail": {
       "type": "boolean",
       "description": "Whether to always include a value in the \"email\" field for the organizer, creator and attendees, even if no real email is available (i.e. a generated, non-working value will be provided). The use of this option is discouraged and should only be used by clients which cannot handle the absence of an email address value in the mentioned places. Optional. The default is False.",
       "location": "query"
      },
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "eventId": {
       "type": "string",
       "description": "Event identifier.",
       "required": true,
       "location": "path"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "sendNotifications": {
       "type": "boolean",
       "description": "Whether to send notifications about the event update (e.g. attendee's responses, title changes, etc.). Optional. The default is False.",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId",
      "eventId"
     ],
     "request": {
      "$ref": "Event"
     },
     "response": {
      "$ref": "Event"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar"
     ]
    },
    "watch": {
     "id": "calendar.events.watch",
     "path": "calendars/{calendarId}/events/watch",
     "httpMethod": "POST",
     "description": "Watch for changes to Events resources.",
     "parameters": {
      "alwaysIncludeEmail": {
       "type": "boolean",
       "description": "Whether to always include a value in the \"email\" field for the organizer, creator and attendees, even if no real email is available (i.e. a generated, non-working value will be provided). The use of this option is discouraged and should only be used by clients which cannot handle the absence of an email address value in the mentioned places. Optional. The default is False.",
       "location": "query"
      },
      "calendarId": {
       "type": "string",
       "description": "Calendar identifier.",
       "required": true,
       "location": "path"
      },
      "iCalUID": {
       "type": "string",
       "description": "Specifies iCalendar UID (iCalUID) of events to be included in the response. Optional.",
       "location": "query"
      },
      "maxAttendees": {
       "type": "integer",
       "description": "The maximum number of attendees to include in the response. If there are more than the specified number of attendees, only the participant is returned. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "maxResults": {
       "type": "integer",
       "description": "Maximum number of events returned on one result page. Optional.",
       "format": "int32",
       "minimum": "1",
       "location": "query"
      },
      "orderBy": {
       "type": "string",
       "description": "The order of the events returned in the result. Optional. The default is an unspecified, stable order.",
       "enum": [
        "startTime",
        "updated"
       ],
       "enumDescriptions": [
        "Order by the start date/time (ascending). This is only available when querying single events (i.e. the parameter \"singleEvents\" is True)",
        "Order by last modification time (ascending)."
       ],
       "location": "query"
      },
      "pageToken": {
       "type": "string",
       "description": "Token specifying which result page to return. Optional.",
       "location": "query"
      },
      "q": {
       "type": "string",
       "description": "Free text search terms to find events that match these terms in any field, except for extended properties. Optional.",
       "location": "query"
      },
      "showDeleted": {
       "type": "boolean",
       "description": "Whether to include deleted events (with 'status' equals 'cancelled') in the result. Cancelled instances of recurring events (but not the underlying recurring event) will still be included if 'showDeleted' and 'singleEvents' are both False. If 'showDeleted' and 'singleEvents' are both True, only single instances of deleted events (but not the underlying recurring events) are returned. Optional. The default is False.",
       "location": "query"
      },
      "showHiddenInvitations": {
       "type": "boolean",
       "description": "Whether to include hidden invitations in the result. Optional. The default is False.",
       "location": "query"
      },
      "singleEvents": {
       "type": "boolean",
       "description": "Whether to expand recurring events into instances and only return single one-off events and instances of recurring events, but not the underlying recurring events themselves. Optional. The default is False.",
       "location": "query"
      },
      "timeMax": {
       "type": "string",
       "description": "Upper bound (exclusive) for an event's start time to filter by. Optional. The default is not to filter by start time.",
       "format": "date-time",
       "location": "query"
      },
      "timeMin": {
       "type": "string",
       "description": "Lower bound (inclusive) for an event's end time to filter by. Optional. The default is not to filter by end time.",
       "format": "date-time",
       "location": "query"
      },
      "timeZone": {
       "type": "string",
       "description": "Time zone used in the response. Optional. The default is the time zone of the calendar.",
       "location": "query"
      },
      "updatedMin": {
       "type": "string",
       "description": "Lower bound for an event's last modification time (as a RFC 3339 timestamp) to filter by. Optional. The default is not to filter by last modification time.",
       "format": "date-time",
       "location": "query"
      }
     },
     "parameterOrder": [
      "calendarId"
     ],
     "request": {
      "$ref": "Channel"
     },
     "response": {
      "$ref": "Channel"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ],
     "supportsSubscription": true
    }
   }
  },
  "freebusy": {
   "methods": {
    "query": {
     "id": "calendar.freebusy.query",
     "path": "freeBusy",
     "httpMethod": "POST",
     "description": "Returns free/busy information for a set of calendars.",
     "request": {
      "$ref": "FreeBusyRequest"
     },
     "response": {
      "$ref": "FreeBusyResponse"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    }
   }
  },
  "settings": {
   "methods": {
    "get": {
     "id": "calendar.settings.get",
     "path": "users/me/settings/{setting}",
     "httpMethod": "GET",
     "description": "Returns a single user setting.",
     "parameters": {
      "setting": {
       "type": "string",
       "description": "Name of the user setting.",
       "required": true,
       "location": "path"
      }
     },
     "parameterOrder": [
      "setting"
     ],
     "response": {
      "$ref": "Setting"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    },
    "list": {
     "id": "calendar.settings.list",
     "path": "users/me/settings",
     "httpMethod": "GET",
     "description": "Returns all user settings for the authenticated user.",
     "response": {
      "$ref": "Settings"
     },
     "scopes": [
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/calendar.readonly"
     ]
    }
   }
  }
 }
}    
    eos
  end
end
