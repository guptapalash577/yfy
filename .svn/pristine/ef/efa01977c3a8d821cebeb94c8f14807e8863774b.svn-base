CREATE TABLE  IF NOT EXISTS  tbl_installed_patches (
patch_name      VARCHAR(256) NOT NULL,
status       VARCHAR(20) DEFAULT 'true' NOT NULL,
CREATED_ON  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT  unique_patch_name  UNIQUE (patch_name)
);