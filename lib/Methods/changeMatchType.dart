String changeMatchIdType(String matchId, String type) {
  matchId = matchId.substring(0, 1) + type.toUpperCase() + matchId.substring(2);

  return matchId;
}
