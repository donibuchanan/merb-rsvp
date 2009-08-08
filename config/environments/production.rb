Merb.logger.info("Loaded PRODUCTION Environment...")
Merb::Config.use { |c|
  c[:exception_details] = false
  c[:reload_templates] = true
  c[:reload_classes] = true
  c[:log_level] = :error
  c[:log_file]  = Merb.root / "log" / "production.log"
  # or redirect logger using IO handle
  # c[:log_stream] = STDOUT
}
