import os
from anthropic import Anthropic
from dotenv import load_dotenv
import logging

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Environment variables
TAVILY_API_KEY = os.getenv("TAVILY_API_KEY", None)
SEARXNG_URL = os.getenv("SEARXNG_URL", None)
CLAUDE_MODEL = os.getenv("CLAUDE_MODEL", "claude-3-5-sonnet-20240620")
SEARCH_RESULTS_LIMIT = int(os.getenv('SEARXNG_RESULTS', '5'))
SEARCH_PROVIDER = os.getenv("SEARCH_PROVIDER", "SEARXNG").upper()

# Validate required environment variables
if not os.getenv("ANTHROPIC_API_KEY"):
    raise ValueError("Missing required environment variable: ANTHROPIC_API_KEY")

if SEARCH_PROVIDER == "TAVILY" and not TAVILY_API_KEY:
    raise ValueError("Missing required environment variable: TAVILY_API_KEY for Tavily")

# Initialize Tavily client if needed
tavily_client = None
if SEARCH_PROVIDER == "TAVILY":
    from tavily import TavilyClient
    tavily_client = TavilyClient(api_key=TAVILY_API_KEY)

# Initialize Anthropic client
anthropic_client = Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))

# Ensure project directories exist
try:
    PROJECTS_DIR = os.path.abspath("projects")
    os.makedirs(PROJECTS_DIR, exist_ok=True)

    UPLOADS_DIR = os.path.join(PROJECTS_DIR, "uploads")
    os.makedirs(UPLOADS_DIR, exist_ok=True)
except OSError as e:
    raise RuntimeError(f"Failed to create project directories: {e}")

# Logging setup
logger.info(f"Using search provider: {SEARCH_PROVIDER}")
logger.info(f"Projects directory: {PROJECTS_DIR}")
logger.info(f"Uploads directory: {UPLOADS_DIR}")