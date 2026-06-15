CREATE TYPE "application_status" AS ENUM('pending', 'selected', 'rejected', 'standby');--> statement-breakpoint
CREATE TYPE "casting_status" AS ENUM('open', 'closed', 'in_progress', 'completed');--> statement-breakpoint
CREATE TYPE "production_type" AS ENUM('advertising', 'cinema', 'television', 'theater', 'other');--> statement-breakpoint
CREATE TYPE "talent_type" AS ENUM('actor', 'actress', 'model', 'extra', 'child_actor', 'other');--> statement-breakpoint
CREATE TYPE "user_role" AS ENUM('talent', 'agent', 'director', 'admin');--> statement-breakpoint
CREATE TABLE "agencies" (
	"id" serial PRIMARY KEY,
	"user_id" integer NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"website" text,
	"phone" text,
	"email" text,
	"address" text,
	"city" text,
	"state" text,
	"logo_url" text,
	"is_accredited" boolean DEFAULT false,
	"specialties" text,
	"talent_count" integer DEFAULT 0,
	"founded_year" integer,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "casting_applications" (
	"id" serial PRIMARY KEY,
	"casting_id" integer NOT NULL,
	"talent_id" integer NOT NULL,
	"status" "application_status" DEFAULT 'pending'::"application_status" NOT NULL,
	"message" text,
	"notes" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "casting_calls" (
	"id" serial PRIMARY KEY,
	"director_id" integer,
	"agency_id" integer,
	"title" text NOT NULL,
	"description" text NOT NULL,
	"production_type" "production_type" NOT NULL,
	"status" "casting_status" DEFAULT 'open'::"casting_status" NOT NULL,
	"location" text,
	"city" text,
	"state" text,
	"talent_type" text,
	"age_min" integer,
	"age_max" integer,
	"gender_required" text,
	"requirements" text,
	"compensation" text,
	"shooting_date" text,
	"application_deadline" timestamp,
	"contact_email" text,
	"is_public" boolean DEFAULT true,
	"view_count" integer DEFAULT 0,
	"application_count" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "casting_directors" (
	"id" serial PRIMARY KEY,
	"user_id" integer NOT NULL,
	"company" text,
	"specialty" text,
	"city" text,
	"state" text,
	"phone" text,
	"website" text,
	"logo_url" text,
	"project_count" integer DEFAULT 0,
	"advertising_count" integer DEFAULT 0,
	"cinema_count" integer DEFAULT 0,
	"tv_count" integer DEFAULT 0,
	"is_subscribed" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "platform_stats" (
	"id" serial PRIMARY KEY,
	"total_talents" integer DEFAULT 0,
	"total_agencies" integer DEFAULT 0,
	"total_directors" integer DEFAULT 0,
	"total_productions" integer DEFAULT 0,
	"advertising_count" integer DEFAULT 0,
	"cinema_count" integer DEFAULT 0,
	"tv_count" integer DEFAULT 0,
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "portfolio_items" (
	"id" serial PRIMARY KEY,
	"talent_id" integer NOT NULL,
	"type" text DEFAULT 'photo' NOT NULL,
	"url" text NOT NULL,
	"caption" text,
	"is_primary" boolean DEFAULT false,
	"sort_order" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "productions" (
	"id" serial PRIMARY KEY,
	"director_id" integer NOT NULL,
	"title" text NOT NULL,
	"type" "production_type" NOT NULL,
	"year" integer,
	"description" text,
	"image_url" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "talent_profiles" (
	"id" serial PRIMARY KEY,
	"user_id" integer NOT NULL,
	"talent_type" "talent_type" DEFAULT 'actor'::"talent_type" NOT NULL,
	"stage_name" text,
	"birth_year" integer,
	"gender" text,
	"height" integer,
	"weight" integer,
	"eye_color" text,
	"hair_color" text,
	"skin_tone" text,
	"city" text,
	"state" text,
	"country" text DEFAULT 'Brasil',
	"languages" text,
	"special_skills" text,
	"experience" text,
	"drt_number" text,
	"agency_id" integer,
	"profile_completed" boolean DEFAULT false,
	"featured_photo_url" text,
	"is_premium" boolean DEFAULT false,
	"view_count" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" serial PRIMARY KEY,
	"identity_id" text UNIQUE,
	"email" text NOT NULL UNIQUE,
	"name" text NOT NULL,
	"role" "user_role" DEFAULT 'talent'::"user_role" NOT NULL,
	"phone" text,
	"location" text,
	"bio" text,
	"avatar_url" text,
	"is_verified" boolean DEFAULT false,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "agencies" ADD CONSTRAINT "agencies_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "casting_applications" ADD CONSTRAINT "casting_applications_casting_id_casting_calls_id_fkey" FOREIGN KEY ("casting_id") REFERENCES "casting_calls"("id");--> statement-breakpoint
ALTER TABLE "casting_applications" ADD CONSTRAINT "casting_applications_talent_id_talent_profiles_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talent_profiles"("id");--> statement-breakpoint
ALTER TABLE "casting_calls" ADD CONSTRAINT "casting_calls_director_id_casting_directors_id_fkey" FOREIGN KEY ("director_id") REFERENCES "casting_directors"("id");--> statement-breakpoint
ALTER TABLE "casting_calls" ADD CONSTRAINT "casting_calls_agency_id_agencies_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "agencies"("id");--> statement-breakpoint
ALTER TABLE "casting_directors" ADD CONSTRAINT "casting_directors_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");--> statement-breakpoint
ALTER TABLE "portfolio_items" ADD CONSTRAINT "portfolio_items_talent_id_talent_profiles_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talent_profiles"("id");--> statement-breakpoint
ALTER TABLE "productions" ADD CONSTRAINT "productions_director_id_casting_directors_id_fkey" FOREIGN KEY ("director_id") REFERENCES "casting_directors"("id");--> statement-breakpoint
ALTER TABLE "talent_profiles" ADD CONSTRAINT "talent_profiles_user_id_users_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id");