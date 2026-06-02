from django.contrib import admin

from .models import FaceObservation


@admin.register(FaceObservation)
class FaceObservationAdmin(admin.ModelAdmin):
    list_display = ("id", "machine", "observed_at", "gender", "age", "age_range",
                    "dominant_emotion", "is_smiling", "matched_visit_id", "source")
    list_filter = ("gender", "age_range", "dominant_emotion", "is_smiling", "source")
    search_fields = ("machine__machine_id",)
    readonly_fields = ("created_at", "inference_meta", "emotion_scores")
    date_hierarchy = "observed_at"
